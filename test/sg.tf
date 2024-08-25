resource "aws_security_group" "sample-sg-bastion" {
    name = "sample-sg-bastion"
    description = "for bastion Server"
    vpc_id = aws_vpc.sample-vpc.id
    tags = {
      "Name" = "sample-sg-bastion"
    }
}

resource "aws_security_group_rule" "sample_sg-bastion-ingress" {
    security_group_id = aws_security_group.sample-sg-bastion.id
    type = "ingress"
    description = "allow all for ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  
}

resource "aws_security_group_rule" "sample-sg-bastion-egress" {
    security_group_id = aws_security_group.sample-sg-bastion.id
    type = "egress"
    description = "allow all for all outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  
}


#### elb sg
resource "aws_security_group" "sample-sg-elb" {
    name = "sample-sg-elb"
    description = "for load balancer"
    vpc_id = aws_vpc.sample-vpc.id
    tags = {
      "Name" = "sample-sg-elb"
    }  
}

resource "aws_security_group_rule" "sample-sg-elb-ingress" {
    security_group_id = aws_security_group.sample-sg-elb.id
    type = "ingress"
    description = "allow all http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "sample-sg-elb-egress" {
    security_group_id = aws_security_group.sample-sg-elb.id
    type = "egress"
    description = "allow all"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  
}


