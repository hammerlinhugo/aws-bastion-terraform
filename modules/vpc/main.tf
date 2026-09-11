resource "aws_vpc" "main" {
  cidr_block  = var.vpc_cidr
  enable_dns_support  = true
  enable_dns_hostnames  = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-public-a"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.prefix}-prive-a"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "{var.prefix}-igw"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "{var.prefix}-eip"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public.id

  depends_on = [ aws_internet_gateway.main ]

  tags = {
    Name = "{var.prefix}-nat"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "{var.prefix}-rt-public"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id  
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "{var.prefix}-rt-prive"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id  
}