data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = [137112412989]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "${var.prefix}-cle"
  public_key = file(pathexpand(var.public_key_path))

  tags = {
    Name = "${var.prefix}-cle"
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.bastion_security_group_id]
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.prefix}-bastion"
  }
}


resource "aws_instance" "app" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.private_security_group_id]
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = false

  tags = {
    Name = "${var.prefix}-app"
  }
}