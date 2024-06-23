provider "aws" {
  region = var.region
}

resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "dev_public_sub" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "public_sub"
  }
}

resource "aws_subnet" "dev_private_sub" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "private_sub"
  }
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev_igw"
  }
}

resource "aws_route_table" "dev_public_rtb" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }

  tags = {
    Name = "dev_public_rtb"
  }
}

resource "aws_route_table_association" "dev_public_sub_association" {
  subnet_id      = aws_subnet.dev_public_sub.id
  route_table_id = aws_route_table.dev_public_rtb.id
}

resource "aws_route_table" "dev_private_rtb" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev_private_rtb"
  }
}

resource "aws_route_table_association" "dev_private_sub_association" {
  subnet_id      = aws_subnet.dev_private_sub.id
  route_table_id = aws_route_table.dev_private_rtb.id
}

