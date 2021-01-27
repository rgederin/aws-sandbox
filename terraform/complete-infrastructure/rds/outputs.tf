output "rds_endpoint" {
  value = aws_db_instance.postgres_instance.endpoint
}
