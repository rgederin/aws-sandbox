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

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Custom VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.public_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1_cidr_block
  availability_zone       = var.public_subnet_1_az
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet _ 1"
  }
}


resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_1_cidr_block
  availability_zone       = var.private_subnet_1_az
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet #1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_2_cidr_block
  availability_zone       = var.private_subnet_2_az
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet #2"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public route table targeting to internet gateway"
  }
}

resource "aws_route_table_association" "public_route_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_launch_template" "public_subnet_launch_template" {
  image_id      = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = "${aws_iam_instance_profile.ec2_instance_profile.name}"
  }
  vpc_security_group_ids = [aws_security_group.ec2_public_security_group.id]

  user_data = "${base64encode(data.template_file.public_ec2_user_data.rendered)}"
}

resource "aws_autoscaling_group" "public_subnet_autoscalling_group" {
  max_size = 2
  min_size = 2

  vpc_zone_identifier = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_1.id]
  target_group_arns   = [aws_lb_target_group.load_balancer_target_group.arn]

  launch_template {
    id      = aws_launch_template.public_subnet_launch_template.id
    version = "$Latest"
  }
}


resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
}

resource "aws_sqs_queue" "sqs_queue" {
  name = var.sqs_queue_name
}



resource "aws_security_group" "ec2_public_security_group" {
  name   = "ec2_public_security_group"
  vpc_id = aws_vpc.vpc.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_dynamodb_table" "username_dynamodb_table" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserName"

  attribute {
    name = "UserName"
    type = "S"
  }
}


resource "aws_iam_instance_profile" "ec2_instance_profile" {
  role = aws_iam_role.ec2_iam_role.name
}

resource "aws_iam_role" "ec2_iam_role" {
  path = "/"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  role = aws_iam_role.ec2_iam_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "sqs:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "sns:*",
        "Resource": "*"
      },
      {
        "Action": [
          "dynamoDb:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}


resource "aws_lb_target_group" "load_balancer_target_group" {
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    port = 80
    path = "/health"
  }
}

resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
  }
}

resource "aws_lb" "application_load_balancer" {
  name               = "load-balancer"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_public_security_group.id]
  # subnets            = [var.public_subnet_id, var.private_subnet_id]
  subnets = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_1.id, ]
}
