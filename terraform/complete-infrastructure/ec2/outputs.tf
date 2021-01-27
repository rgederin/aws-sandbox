output "nat_ec2_instance_id" {
  value = aws_instance.nat_ec2.id
}

output "load-balancer-endpoint" {
  value = aws_lb.application_load_balancer.dns_name
}
