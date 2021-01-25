output "load_balancer_dns" {
  value = aws_lb.application_load_balancer.dns_name
}
