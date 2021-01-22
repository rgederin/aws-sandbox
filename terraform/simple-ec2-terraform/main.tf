resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
}
