resource "aws_lb_target_group" "load_balancer_target_group" {
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    port = 80
    path = "/health"
  }
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
  security_groups    = [aws_security_group.public_subnet_security_group.id]
  # subnets            = [var.public_subnet_id, var.private_subnet_id]
  subnets = [var.first_public_subnet_id, var.second_public_subnet_id]
}

