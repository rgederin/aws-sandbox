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

resource "aws_security_group" "ingress_rds" {
  name = "ingress_rds"

  ingress {
    from_port = 5432
    protocol = "tcp"
    to_port = 5432
    security_groups = [aws_security_group.ingress_ssh.id]
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
