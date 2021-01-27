output "rds_endpoint" {
  value = module.postgres_instance.rds_endpoint
}

output "sns_topic_arn" {
  value = module.messaging.sns_topic_arn
}

output "sqs_queue_url" {
  value = module.messaging.sqs_queue_url
}

output "load-balancer-endpoint" {
  value = module.ec2.load-balancer-endpoint
}

