resource "aws_lb_target_group" "load_balancer_target_group" {
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    port = 80
    path = "/index.html"
  }
}

resource "aws_lb_target_group_attachment" "public_ec2_attachment" {
  target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
  target_id        = aws_instance.public_ec2_instance.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "private_ec2_attachment" {
  target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
  target_id        = aws_instance.private_ec2_instance.id
  port             = 80
}

resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
  }
}

resource "aws_lb" "application_load_balancer" {
  name               = "load-balancer"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_public_security_group.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
}
