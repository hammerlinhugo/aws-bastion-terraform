variable "prefix" {
  description = "Prefixe utilise pour nommer les ressources (=10)"
  type        = string
}

variable "vpc_id" {
  description = "Identifiant du VPC"
  type        = string
}

variable "my_ip_cidr" {
  description = "Adresse IP pour la connexion en SSH au bastion"
  type        = string
}