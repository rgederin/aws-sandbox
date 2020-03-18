resource "aws_security_group" "ingress_ssh" {
  name = "ingress_ssh"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_security_group" "egress_all" {
  name = "egress_all"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}