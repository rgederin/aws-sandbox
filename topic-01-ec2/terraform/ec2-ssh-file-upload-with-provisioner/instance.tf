resource "aws_instance" "rgederin-ec2" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.EC2_INSTANCE_TYPE
  key_name = "rgederin-aws-key-pair"
  security_groups = [aws_security_group.ssh-security-group.name]

  provisioner "file" {
    source = "install-java-script.sh"
    destination = "/tmp/install-java-script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-java-script.sh",
      "/tmp/install-java-script.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.rgederin-ec2.private_ip} >> private_ips.txt"
  }

  connection {
    user = var.EC2_INSTANTCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
    host = self.public_ip
  }
}

output "ec2-ip" {
  value = aws_instance.rgederin-ec2.public_ip
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

