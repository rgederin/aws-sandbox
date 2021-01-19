resource "aws_instance" "rgederin_ec2" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
}
