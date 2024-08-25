resource "aws_instance" "sample-ec2-web02" {
  ami             = "ami-0dfabddd52dec98c7"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_default_security_group.default.id]
  subnet_id       = aws_subnet.sample-subnet-private02.id
  associate_public_ip_address = false
  key_name        = "hp"
  user_data = <<EOF
		#! /bin/bash
	  sudo yum install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "This is Test Server" | sudo tee /usr/share/nginx/html/index.html
  EOF
  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "sample-ec2-web02"
    }
  }
  tags = {
    "Name" = "sample-ec2-web02"
  }


}