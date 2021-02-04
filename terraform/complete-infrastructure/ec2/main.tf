data "template_file" "public_ec2_user_data" {
  template = <<EOF
    #!/bin/bash
    sudo su
    
    yum -y update 
    yum -y install java-1.8.0-openjdk

    aws s3api get-object --bucket rgederin-bucket --key calc-2021-0.0.1-SNAPSHOT.jar calc-2021-0.0.1-SNAPSHOT.jar
    java -jar calc-2021-0.0.1-SNAPSHOT.jar
  EOF
}

resource "aws_launch_template" "public_subnet_launch_template" {
  image_id      = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = "${aws_iam_instance_profile.ec2_instance_profile.name}"
  }
  vpc_security_group_ids = [aws_security_group.public_subnet_security_group.id]

  user_data = "${base64encode(data.template_file.public_ec2_user_data.rendered)}"
}

resource "aws_autoscaling_group" "public_subnet_autoscalling_group" {
  max_size = 2
  min_size = 2

  vpc_zone_identifier = [var.first_public_subnet_id, var.second_public_subnet_id]
  target_group_arns   = [aws_lb_target_group.load_balancer_target_group.arn]

  launch_template {
    id      = aws_launch_template.public_subnet_launch_template.id
    version = "$Latest"
  }
}

resource "aws_instance" "private_subnet_ec2" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.private_subnet_security_group.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.id
  key_name               = var.key_name

  user_data = <<-EOF
		#!/bin/bash
    sudo su

    export RDS_HOST=${var.rds_address}
    echo $RDS_HOST 

    yum -y update 
    yum -y install java-1.8.0-openjdk
    aws s3api get-object --bucket rgederin-bucket --key persist3-2021-0.0.1-SNAPSHOT.jar persist3-2021-0.0.1-SNAPSHOT.jar

    java -jar persist3-2021-0.0.1-SNAPSHOT.jar
	EOF

  tags = {
    name = "private_ec2_instance"
  }
}

resource "aws_instance" "nat_ec2" {
  ami                    = var.nat_ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.first_public_subnet_id
  key_name               = var.key_name
  source_dest_check      = false
  vpc_security_group_ids = [aws_security_group.public_subnet_security_group.id]

  tags = {
    name = "nat_ec2"
  }
}
