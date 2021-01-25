resource "aws_sns_topic" "sns_topic" {
  name = "sns_topic"
}

resource "aws_sqs_queue" "sqs_queue" {
  name = "sqs_queue"
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name

  security_groups = [
    aws_security_group.egress_all.name,
    aws_security_group.ingress_ssh.name,
    aws_security_group.ingress_http.name
  ]

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
}
