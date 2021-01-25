resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    name = "custom VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.public_subnet_az
  map_public_ip_on_launch = true

  tags = {
    name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_block
  availability_zone       = var.private_subnet_az
  map_public_ip_on_launch = true

  tags = {
    name = "private_subnet"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat_ec2_instance.id
  }

  tags = {
    Name = "default (private) route table targeting to nat ec2 instance"
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

resource "aws_instance" "public_ec2_instance" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_public_security_group.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
		#!/bin/bash -xe
    sudo su
    yum update -y
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    cd /var/www/html/
    echo "<html><h1>WebServer from public subnet</h1></html>" > index.html
    EOF


  tags = {
    name = "public_ec2_instance"
  }
}

resource "aws_instance" "private_ec2_instance" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_private_security_group.id]
  key_name                    = var.key_name
  associate_public_ip_address = false
  user_data                   = <<-EOF
		#!/bin/bash -xe
    sudo su
    yum update -y
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    cd /var/www/html/
    echo "<html><h1>WebServer from private subnet</h1></html>" > index.html
    EOF

  tags = {
    name = "private_ec2_instance"
  }
}

resource "aws_instance" "nat_ec2_instance" {
  ami                    = var.nat_ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_public_security_group.id]
  source_dest_check      = false
  key_name               = var.key_name

  tags = {
    name = "nat_ec2_instance"
  }
}

