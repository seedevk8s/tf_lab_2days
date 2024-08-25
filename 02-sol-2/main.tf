
locals {
  cluster_name = "sample-eks"
}

module "eks" {
  # eks 모듈에서 사용할 변수 #
  source = "./modules/eks-cluster"
  cluster_name = local.cluster_name
  cluster_version = "1.29"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
  region = "ap-northeast-2"
}

output "default_security_group_id" {
  value = module.eks.default_security_group_id
}



output "aws_account_id" {
  value = module.eks.aws_account_id
}
