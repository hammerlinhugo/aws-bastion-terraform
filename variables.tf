variable "aws_region" {
  description = "Région AWS utilisée"
  type        = string
}

variable "prefix" {
  description = "Prefixe utilise pour nommer les ressources (=10)"
  type        = string
}

variable "vpc_cidr" {
  description = "Plage CIDR du VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Plage CIDR du sous-reseau public"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Plage CIDR du sous-reseau prive"
  type        = string
}

variable "availability_zone" {
  description = "Zone de disponibilite utilisee"
  type        = string
}

variable "my_ip_cidr" {
  description = "Adresse IP publique du poste autorisé en SSH"
  type        = string
}

variable "public_key_path" {
  description = "Chemin vers cle SSH publique"
}

variable "instance_type" {
  description = "Type des instances"
  type        = string
  default     = "t3.micro"

}