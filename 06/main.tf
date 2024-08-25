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

module "s3" {
  source       = "./modules"
  bucket_names = ["kosta001", "kosta002", "kosta003"]
}


output "bucket_names" {
  value = module.s3.bucket_names
}
