#data "aws_eks_cluster" "cluster" {
#  name = module.eks.cluster_name
#}


data "aws_caller_identity" "current" {}


data "aws_security_group" "default-sg" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "group-name"
    values = ["default"]
  }
}


data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.virginia
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  
}
