output "vpc_id" {
  description = "Identifiant du VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Identifiant du sous-réseau public"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "Identifiant du sous-réseau privé"
  value       = module.vpc.private_subnet_id
}

output "nat_public_ip" {
  description = "Adresse IP publique de la NAT"
  value       = module.vpc.nat_public_ip
}

output "bastion_security_group_id" {
  description = "Security Group du Bastion"
  value       = module.security.bastion_security_group_id
}

output "private_security_group_id" {
  description = "Security Group du Bastion"
  value       = module.security.bastion_security_group_id
}

output "bastion_public_ip" {
  description = "Adresse publique du bastion"
  value       = module.ec2.bastion_public_ip
}

output "bastion_private_ip" {
  description = "Adresse privee du bastion"
  value       = module.ec2.bastion_private_ip
}

output "app_private_ip" {
  description = "Adresse privee de l'instance applicative"
  value       = module.ec2.app_private_ip
}

output "ami_id" {
  description = "AMI Amazon Linux utilisee"
  value       = module.ec2.ami_id
}