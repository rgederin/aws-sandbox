output "public_id" {
  value = aws_instance.ec2_with_rds_dynamodb_access.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.postgres_instance.endpoint
}

