output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_default_route_table_id" {
  value = aws_vpc.vpc.default_route_table_id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}
