locals {
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  region             = var.region
  vpc_id             = var.vpc_id
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  aws_account_id     = data.aws_caller_identity.current.id
  private_subnet_map = { for idx, subnet in local.private_subnets : idx => subnet }
  public_subnet_map  = { for idx, subnet in local.public_subnets : idx => subnet }
}

resource "aws_ec2_tag" "private_subnet_tag" {
  for_each    = local.private_subnet_map
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

resource "aws_ec2_tag" "private_subnet_cluster_tag" {
  for_each    = local.private_subnet_map
  resource_id = each.value
  key         = "kubernetes.io/cluster/${local.cluster_name}"
  value       = "owned"
}

resource "aws_ec2_tag" "private_subnet_karpenter_tag" {
  for_each    = local.private_subnet_map
  resource_id = each.value
  key         = "karpenter.sh/discovery/${local.cluster_name}"
  value       = local.cluster_name
}

resource "aws_ec2_tag" "public_subnet_tag" {
  for_each    = local.public_subnet_map
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

/* 일부 모듈 지원 때문에 최신버전인 20.x를 사용하지 않음*/

module "eks" {
  # https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  # Cluster Name Setting
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  # Cluster Endpoint Setting
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  ## add on ###
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }


  # Network Setting
  vpc_id     = local.vpc_id
  subnet_ids = local.private_subnets

  # IRSA Enable / OIDC 구성
  enable_irsa = true

  node_security_group_additional_rules = {
    ingress_nodes_http = {
      description                   = "for http"
      protocol                      = "tcp"
      from_port                     = 80
      to_port                       = 80
      type                          = "ingress"
      source_cluster_security_group = true
    }
    ingress_nodes_tcp_8080 = {
      description                   = "for tcp 8080"
      protocol                      = "tcp"
      from_port                     = 8080
      to_port                       = 8080
      type                          = "ingress"
      source_cluster_security_group = true
    }
    /*Defulat Security Group 대신 아래 항목을 사용해도 됩니다. */
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }



  # Tag Node Security Group
  node_security_group_tags = {
    "karpenter.sh/discovery" = local.cluster_name
  }
  node_security_group_id = data.aws_security_group.default-sg.id

  eks_managed_node_groups = {
    one = {
      instance_types        = ["t3.medium"]
      create_security_group = true
      # additional_security_group_ids = [data.aws_security_group.default-sg.id]
      vpc_security_group_ids = [data.aws_security_group.default-sg.id]
      min_size               = 3
      max_size               = 5
      desired_size           = 3

      iam_role_additional_policies = {
        "AmazonSSMManagedInstanceCore" = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }
    }
  }

  # console identity mapping (AWS user)
  # eks configmap aws-auth에 콘솔 사용자 혹은 역할을 등록
  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::${local.aws_account_id}:user/admin"
      username = "admin"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_accounts = [
    local.aws_account_id
  ]
}

resource "null_resource" "update_kubeconfig" {
  # EKS 모듈이 완료될 때까지 기다립니다
  depends_on = [module.eks]

  triggers = {
    cluster_name = module.eks.cluster_name
  }

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"

  }
}
