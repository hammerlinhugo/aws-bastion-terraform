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