terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-2"
}

# 운영 환경
module "prod_network" {
  source           = "./modules"
  env              = "prod"
  cidr_block       = "10.0.0.0/16"
  public_subnets1  = "10.0.0.0/20"
  public_subnets2  = "10.0.16.0/20"
  private_subnets1 = "10.0.64.0/20"
  private_subnets2 = "10.0.80.0/20"
}

# 개발 환경 
module "dev_network" {
  source           = "./modules"
  env              = "dev"
  cidr_block       = "10.0.0.0/16"
  public_subnets1  = "10.0.0.0/20"
  public_subnets2  = "10.0.16.0/20"
  private_subnets1 = "10.0.64.0/20"
  private_subnets2 = "10.0.80.0/20"
}

output "vpc_id" {
  value = module.prod_network.vpc_id


}
