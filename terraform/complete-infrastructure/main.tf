module "dynamodb_table" {
  source              = "./dynamodb"
  dynamodb_table_name = var.dynamodb_table_name
}

module "messaging" {
  source = "./messaging"

  sns_topic_name = var.sns_topic_name
  sqs_queue_name = var.sqs_queue_name
}

module "vpc" {
  source = "./vpc"

  vpc_cidr_block = var.vpc_cidr_block


  first_public_subnet_cidr_block = var.first_public_subnet_cidr_block
  first_public_subnet_az         = var.first_public_subnet_az

  second_public_subnet_cidr_block = var.second_public_subnet_cidr_block
  second_public_subnet_az         = var.second_public_subnet_az

  first_private_subnet_cidr_block = var.first_private_subnet_cidr_block
  first_private_subnet_az         = var.first_private_subnet_az

  second_private_subnet_cidr_block = var.second_private_subnet_cidr_block
  second_private_subnet_az         = var.second_private_subnet_az
}

module "postgres_instance" {
  source = "./rds"

  rds_engine          = var.rds_engine
  rds_username        = var.rds_username
  rds_password        = var.rds_password
  rds_db_name         = var.rds_db_name
  private_subnet_1_id = module.vpc.first_private_subnet_id
  private_subnet_2_id = module.vpc.second_private_subnet_id
  vpc_id              = module.vpc.vpc_id
}

module "ec2" {
  source = "./ec2"

  ec2_ami_id              = var.ec2_ami_id
  nat_ec2_ami_id          = var.nat_ec2_ami_id
  ec2_instance_type       = var.ec2_instance_type
  key_name                = var.key_name
  vpc_cidr_block          = var.vpc_cidr_block
  vpc_id                  = module.vpc.vpc_id
  first_public_subnet_id  = module.vpc.first_public_subnet_id
  second_public_subnet_id = module.vpc.second_public_subnet_id
  private_subnet_id       = module.vpc.first_private_subnet_id
  rds_address             = module.postgres_instance.rds_address
}

module "routing" {
  source = "./routing"

  vpc_id                     = module.vpc.vpc_id
  first_public_subnet_id     = module.vpc.first_public_subnet_id
  second_public_subnet_id    = module.vpc.second_public_subnet_id
  vpc_default_route_table_id = module.vpc.vpc_default_route_table_id
  nat_ec2_instance_id        = module.ec2.nat_ec2_instance_id
}


