output "ec2_public_ip" {
  description = "EC2 instance public IP address"
  value       = aws_instance.ec2_instance.public_ip
}

output "sns_topic_arn" {
  description = "SNS topic ARN"
  value       = aws_sns_topic.sns_topic.arn
}

output "sqs_queue_url" {
  description = "SQS queue URL"
  value       = aws_sqs_queue.sqs_queue.id
}
