module "vpc" {
  source = "./modules/vpc"

  prefix              = var.prefix
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
}

module "security" {
  source = "./modules/security"

  prefix     = var.prefix
  vpc_id     = module.vpc.vpc_id
  my_ip_cidr = var.my_ip_cidr
}

module "ec2" {
  source = "./modules/ec2"

  prefix                    = var.prefix
  public_subnet_id          = module.vpc.public_subnet_id
  private_subnet_id         = module.vpc.private_subnet_id
  bastion_security_group_id = module.security.bastion_security_group_id
  private_security_group_id = module.security.private_security_group_id
  public_key_path           = var.public_key_path
  instance_type             = var.instance_type
}