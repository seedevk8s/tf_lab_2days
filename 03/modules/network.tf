resource "aws_vpc" "sample-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "sample-vpc_${var.env}"
  }
}

resource "aws_subnet" "sample-subnet-public01" {
  vpc_id                  = aws_vpc.sample-vpc.id
  cidr_block              = var.public_subnets1
  availability_zone       = local.az_a
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "sample-subnet-public01${var.env}"
  }
}

resource "aws_subnet" "sample-subnet-public02" {
  vpc_id                  = aws_vpc.sample-vpc.id
  cidr_block              = var.public_subnets2
  availability_zone       = local.az_c
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "sample-subnet-public02${var.env}"
  }
}

## pirvate subnet
resource "aws_subnet" "sample-subnet-private01" {
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.private_subnets1
  availability_zone = local.az_a
  tags = {
    "Name" = "sample-subnet-private01${var.env}"
  }
}

resource "aws_subnet" "sample-subnet-private02" {
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.private_subnets2
  availability_zone = local.az_c
  tags = {
    "Name" = "sample-subnet-private02${var.env}"
  }
}
