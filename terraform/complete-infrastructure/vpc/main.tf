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
