resource "aws_launch_configuration" "launch-config" {
  image_id = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.EC2_INSTANCE_TYPE
  key_name = var.KEY_PAIR
  security_groups = [aws_security_group.ssh-security-group.name]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum install java-1.8.0-openjdk -y
              EOF
}

resource "aws_autoscaling_group" "autoscalling-group" {
  max_size = 2
  min_size = 2
  availability_zones = ["us-east-1a"]
  launch_configuration = aws_launch_configuration.launch-config.name
}

resource "aws_security_group" "ssh-security-group" {
  name = "ssh-security-group"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

