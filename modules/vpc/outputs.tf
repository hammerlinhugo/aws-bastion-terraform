output "vpc_id" {
  description = "Identifiant du VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Identifiant du sous-réseau public"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "Identifiant du sous-réseau privé"
  value       = aws_subnet.private.id
}

output "public_route_table_id" {
  description = "Identifiant de la table de routage publique"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "Identifiant de la table de routage privée"
  value       = aws_route_table.private.id
}

output "nat_public_ip" {
  description = "Adresse IP publique de la NAT"
  value       = aws_eip.nat.public_ip
}