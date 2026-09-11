output "bastion_public_ip" {
  description = "Adresse IPv4 publique du bastion"
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "Adresse IPv4 privee du bastion"
  value       = aws_instance.bastion.private_ip
}

output "app_private_ip" {
  description = "Adresse IPv4 privee de l'instance applicative"
  value       = aws_instance.app.private_ip
}

output "ami_id" {
  description = "AMI Amazon Linux utilisee"
  value       = data.aws_ami.amazon_linux.id
}