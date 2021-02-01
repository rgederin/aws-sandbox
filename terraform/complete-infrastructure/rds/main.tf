resource "aws_db_instance" "postgres_instance" {
  name                   = var.rds_db_name
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = var.rds_engine
  engine_version         = "12.3"
  instance_class         = "db.t2.micro"
  username               = var.rds_username
  password               = var.rds_password
  vpc_security_group_ids = [aws_security_group.postgres_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  skip_final_snapshot    = true
  publicly_accessible    = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  subnet_ids = [var.private_subnet_1_id, var.private_subnet_2_id]
}

resource "aws_security_group" "postgres_security_group" {
  name   = "postgres_security_group"
  vpc_id = var.vpc_id
  # postgres access from anywhere
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
