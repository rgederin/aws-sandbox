resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = var.vpc_default_route_table_id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = var.nat_ec2_instance_id
  }

  tags = {
    Name = "default route table"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "first_subnet_public_route_table_association" {
  subnet_id      = var.first_public_subnet_id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "second_subnet_public_route_table_association" {
  subnet_id      = var.second_public_subnet_id
  route_table_id = aws_route_table.public_route_table.id
}
