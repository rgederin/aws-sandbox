output "public_id" {
  description = "EC2 instance public IP address"
  value       = aws_instance.ec2_instance.public_ip
}
