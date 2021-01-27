# module "dynamodb_table" {
#   source              = "./dynamodb"
#   dynamodb_table_name = var.dynamodb_table_name
# }

# module "postgres_instance" {
#   source = "./rds"

#   rds_engine   = var.rds_engine
#   rds_username = var.rds_username
#   rds_password = var.rds_password
#   rds_db_name  = var.rds_db_name
# }

# module "messaging" {
#   source = "./messaging"

#   sns_topic_name = var.sns_topic_name
#   sqs_queue_name = var.sqs_queue_name
# }

module "vpc" {
  source = "./vpc"

  vpc_cidr_block            = var.vpc_cidr_block
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  public_subnet_az          = var.public_subnet_az
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_subnet_az         = var.private_subnet_az
}

module "ec2" {
  source = "./ec2"

  ec2_ami_id        = var.ec2_ami_id
  nat_ec2_ami_id    = var.nat_ec2_ami_id
  ec2_instance_type = var.ec2_instance_type
  key_name          = var.key_name
  vpc_cidr_block    = var.vpc_cidr_block
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  # depends_on = [
  #   module.vpc
  # ]
}

module "routing" {
  source = "./routing"

  vpc_id                     = module.vpc.vpc_id
  public_subnet_id           = module.vpc.public_subnet_id
  vpc_default_route_table_id = module.vpc.vpc_default_route_table_id
  nat_ec2_instance_id        = module.ec2.nat_ec2_instance_id
}


