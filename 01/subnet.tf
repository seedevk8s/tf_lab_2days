data "aws_vpc" "example" {
  filter {
    name   = "tag:Name"
    values = ["example-vpc"]
  }
}

resource "aws_subnet" "example-public-subnet01" {
  vpc_id                  = data.aws_vpc.example.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "example-public-subnet01"
  }
}
