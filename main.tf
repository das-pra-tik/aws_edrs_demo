module "primary_vpc" {
  source          = "./vpc"
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  providers = {
    aws = aws.us_east
  }
}

module "edrs_vpc" {
  source          = "./vpc"
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  providers = {
    aws = aws.us_west
  }
}

module "rsa_ssh_primary" {
  source        = "./rsa"
  algorithm     = var.algorithm
  rsa_bits      = var.rsa_bits
  key_pair_name = var.key_pair_name_1
  providers = {
    aws = aws.us_east
  }
}

module "rsa_ssh_dr" {
  source        = "./rsa"
  algorithm     = var.algorithm
  rsa_bits      = var.rsa_bits
  key_pair_name = var.key_pair_name_2
  providers = {
    aws = aws.us_west
  }
}

module "nodes_ec2" {
  source               = "./ec2"
  key_pair_name        = module.rsa_ssh_primary.key-pair-name
  instance_type        = var.instance_type
  root_vol_size        = var.root_vol_size
  root_vol_type        = var.root_vol_type
  data_vol_size        = var.data_vol_size
  data_vol_type        = var.data_vol_type
  USER_DATA            = var.USER_DATA
  instance_sec_grp_ids = [module.aws_security_grp_primary.ec2-sg-ids]
  node_subnet_ids      = module.primary_vpc.primary-vpc-public-subnet-ids
  providers = {
    aws = aws.us_east
  }
}

module "aws_security_grp_primary" {
  source    = "./security_grp"
  vpc_id    = module.primary_vpc.vpc-id
  ec2_ports = var.ec2_ports
  providers = {
    aws = aws.us_east
  }
}

module "aws_security_grp_edrs" {
  source    = "./security_grp"
  vpc_id    = module.edrs_vpc.vpc-id
  ec2_ports = var.ec2_ports
  providers = {
    aws = aws.us_west
  }
}
/*
module "aws_kms" {
  source              = "./kms"
  kms_alias_name      = var.kms_alias_name
  kms_enabled         = var.kms_enabled
  kms_rotation        = var.kms_rotation
  kms_deletion_window = var.kms_deletion_window
  key_spec            = var.key_spec
}
*/
