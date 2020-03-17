resource "aws_instance" "rgederin-ec2" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.EC2_INSTANCE_TYPE
}