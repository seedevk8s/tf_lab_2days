####### lb 생성

resource "aws_lb" "web-lb" {
    name = "web-lb"
    subnets = [ aws_subnet.sample-subnet-public01.id, aws_subnet.sample-subnet-public02.id ]
    internal = false
    security_groups = [ aws_security_group.sample-sg-elb.id, aws_default_security_group.default.id ]
    load_balancer_type = "application"
    tags = {
      "Name" = "web-lb"
    }
}

############## Target Group

resource "aws_lb_target_group" "sample-tg" {
    name = "sample-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.sample-vpc.id
    health_check {
      port = 80
      path ="/"
    }
    tags = {
      "Name" = "sample-tg"
    }
}

############Listener 

resource "aws_lb_listener" "sample-listener" {
    load_balancer_arn = aws_lb.web-lb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_lb_target_group.sample-tg.arn
      type = "forward"
    }
  
}

##### target group attachment
resource "aws_lb_target_group_attachment" "sample-tg-attachment1" {
    target_group_arn = aws_lb_target_group.sample-tg.arn
    target_id = aws_instance.sample-ec2-web01.id
    port = 80
  
}

resource "aws_lb_target_group_attachment" "sample-tg-attachment2" {
    target_group_arn = aws_lb_target_group.sample-tg.arn
    target_id = aws_instance.sample-ec2-web02.id
    port = 80
  
}