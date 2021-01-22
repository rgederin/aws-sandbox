resource "aws_launch_template" "launch_template" {
  image_id      = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name
  security_group_names = [
    aws_security_group.ingress_ssh.name,
    aws_security_group.ingress_http.name,
    aws_security_group.egress_all.name
  ]

  user_data = filebase64("${path.module}/scripts/java_install.sh")
}

resource "aws_autoscaling_group" "autoscalling-group" {
  max_size           = 2
  min_size           = 2
  availability_zones = ["us-west-1a"]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}
