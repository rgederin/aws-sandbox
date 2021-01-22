resource "aws_db_instance" "postgres_instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = var.rds_engine
  engine_version         = "12.3"
  instance_class         = "db.t2.micro"
  username               = var.rds_username
  password               = var.rds_password
  vpc_security_group_ids = [aws_security_group.ingress_rds.id]
  skip_final_snapshot    = true
  publicly_accessible    = true
}
