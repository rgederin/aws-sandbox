output "ec2-ip" {
  value = aws_instance.ec2_with_rds_access.public_ip
}

output "rds-endpoint" {
  value = aws_db_instance.postgres-rds-instance.endpoint
}