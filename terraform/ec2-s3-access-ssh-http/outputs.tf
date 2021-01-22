output "public_id" {
  description = "EC2 instance public IP address"
  value       = aws_instance.ec2_with_s3_access.public_ip
}
