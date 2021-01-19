data "template_file" "init" {
  template = "${file("copy_file_from_s3.sh.tpl")}"

  vars = {
    s3_bucket_name        = var.s3_bucket_name
    s3_file_key           = var.s3_file_key
    destination_file_name = var.destination_file_name
  }
}

resource "aws_instance" "ec2_with_s3_access" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name

  security_groups = [
    aws_security_group.egress_all.name,
    aws_security_group.ingress_ssh.name,
    aws_security_group.ingress_http.name
  ]

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data = data.template_file.init.rendered
}
