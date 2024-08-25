resource "aws_eip" "bastion_ip" {
  vpc = true
  tags = {
    "Name" = "bastion_eip"
  }
  instance = aws_instance.sample-ec2-bastion.id
}

resource "aws_instance" "sample-ec2-bastion" {
  ami             = "ami-0dfabddd52dec98c7"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sample-sg-bastion.id,aws_default_security_group.default.id]
  subnet_id       = aws_subnet.sample-subnet-public01.id
  key_name        = "hp"
  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "sample-ec2-bastion"
    }
  }
  tags = {
    "Name" = "sample-ec2-bastion"
  }


}