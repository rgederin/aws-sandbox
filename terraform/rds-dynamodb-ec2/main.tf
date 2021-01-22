data "template_file" "init" {
  template = "${file("scripts/copy_files_from_s3.sh.tpl")}"

  vars = {
    s3_bucket_name               = var.s3_bucket_name
    s3_sql_script_file_name      = var.s3_sql_script_file_name
    s3_dynamodb_script_file_name = var.s3_dynamodb_script_file_name
  }
}

resource "aws_instance" "ec2_with_rds_dynamodb_access" {
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
