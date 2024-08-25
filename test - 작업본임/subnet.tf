### public1 ###
resource "aws_subnet" "sample-subnet-public1" {
  vpc_id                  = aws_vpc.sample-vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "sample-subnet-public1"
  }

}

resource "aws_subnet" "sample-subnet-public2" {
  vpc_id                  = aws_vpc.sample-vpc.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "sample-subnet-public2"
  }

}


## Private subnet ##
resource "aws_subnet" "sample-subnet-private1" {
  vpc_id                  = aws_vpc.sample-vpc.id
  cidr_block              = "10.0.64.0/20"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "sample-subnet-private1"
  }

}

resource "aws_subnet" "sample-subnet-private2" {
  vpc_id                  = aws_vpc.sample-vpc.id
  cidr_block              = "10.0.80.0/20"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "sample-subnet-private2"
  }

}
