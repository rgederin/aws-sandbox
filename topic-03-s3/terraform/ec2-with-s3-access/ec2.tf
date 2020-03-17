resource "aws_instance" "ec2_with_s3_access" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.EC2_INSTANCE_TYPE
  key_name = var.KEY_PAIR

  security_groups = [
    aws_security_group.egress_all.name,
    aws_security_group.ingress_ssh.name
  ]

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data = <<-EOF
              #!/bin/bash
              aws s3api get-object --bucket rgederin-bucket --key rgederin-s3-file.txt rgederin-s3-file.txt
  EOF
}