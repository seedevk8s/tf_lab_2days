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

module "vpc" {
  source             = "./modules"
  cidr_block         = "10.0.0.0/16"
  name               = "sample-vpc"
  public_subnets     = ["10.0.0.0/20", "10.0.16.0/20"]
  private_subnets    = ["10.0.64.0/20", "10.0.80.0/20"]
  availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
