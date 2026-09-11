resource "aws_security_group" "bastion" {
  name        = "${var.prefix}-sg-bastion"
  description = "groupe de securite qui autorise SSH depuis admin"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-sg-bastion"
  }
}

resource "aws_security_group" "private" {
  name        = "${var.prefix}-sg-prive"
  description = "groupe de securite qui autorise SSH uniquement depuis le bastion"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-sg-prive"
  }
}