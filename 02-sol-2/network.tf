locals {
  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  default_security_group_ingress = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      self      = true
    }
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"


  name = "frodo-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets  = ["10.0.0.0/20", "10.0.16.0/20"]
  private_subnets = ["10.0.64.0/20", "10.0.80.0/20"]

  enable_nat_gateway             = true
  single_nat_gateway             = true
  manage_default_security_group  = true
  default_security_group_egress  = local.default_security_group_egress
  default_security_group_ingress = local.default_security_group_ingress

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
