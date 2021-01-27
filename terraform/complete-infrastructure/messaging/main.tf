resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
}

resource "aws_sqs_queue" "sqs_queue" {
  name = var.sqs_queue_name
}
