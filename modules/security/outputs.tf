output "bastion_security_group_id" {
  description = "Identifiant du Security Group du bastion"
  value       = aws_security_group.bastion.id
}

output "private_security_group_id" {
  description = "Identifiant du Security Group privé"
  value       = aws_security_group.private.id
}