variable "prefix" {
  description = "Prefixe utilise pour nommer les ressources"
  type        = string
}

variable "public_subnet_id" {
  description = "Identifiant du sous-reseau public"
  type        = string
}

variable "private_subnet_id" {
  description = "Identifiant du sous-reseau prive"
  type        = string
}

variable "bastion_security_group_id" {
  description = "Identifiant du Security Group du bastion"
  type        = string
}

variable "private_security_group_id" {
  description = "Identifiant du Security Group de l'instance privee"
  type        = string
}

variable "public_key_path" {
  description = "Chemin vers la cle SSH publique locale"
  type        = string
}

variable "instance_type" {
  description = "Type des instances EC2"
  type        = string
  default     = "t3.micro"
}