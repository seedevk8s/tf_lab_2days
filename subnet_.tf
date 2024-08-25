resource "aws_subnet" "sample_public_subnet01" {
  vpc_id                  = "vpc-0afe19797150e1e37"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-2a"
  tags = {
    Name = "example-public-subnet01"
  }
}
