provider "aws" {
  region = var.location
}

// Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc-cidr
}

// Create Subnets
resource "aws_subnet" "public_subnet-1" {
  vpc_id     = aws_vpc.demo-vpc.id 
  cidr_block = var.public_subnet1-cidr
  availability_zone = var.subnet_az-1
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet-1"
  }
}
resource "aws_subnet" "public_subnet-2" {
  vpc_id     = aws_vpc.demo-vpc.id 
  cidr_block = var.public_subnet2-cidr
  availability_zone = var.subnet_az-2
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet-2"
  }
}
resource "aws_subnet" "private_subnet-1" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.private_subnet1-cidr
  availability_zone = var.subnet_az-1
  map_public_ip_on_launch = true
  tags = {
    Name = "private_subnet-1"
  }
}
resource "aws_subnet" "private_subnet-2" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.private_subnet2-cidr
  availability_zone = var.subnet_az-2
  map_public_ip_on_launch = true
    tags = {
    Name = "private_subnet-2"
  }
}
// Create Internet Gateway

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  tags = {
    Name = "demo-rt"
  }
}

// associate subnet with route table 
resource "aws_route_table_association" "demo-rt_association1" {
  subnet_id      = aws_subnet.public_subnet-1.id 

  route_table_id = aws_route_table.demo-rt.id
}
resource "aws_route_table_association" "demo-rt_association2" {
  subnet_id      = aws_subnet.public_subnet-2.id 

  route_table_id = aws_route_table.demo-rt.id
}
resource "aws_route_table_association" "demo-rt_association3" {
  subnet_id      = aws_subnet.private_subnet-2.id 

  route_table_id = aws_route_table.demo-rt.id
}
resource "aws_route_table_association" "demo-rt_association4" {
  subnet_id      = aws_subnet.private_subnet-2.id 

  route_table_id = aws_route_table.demo-rt.id
}

module "sgs" {
  source = "./sg_eks"
  vpc_id = aws_vpc.demo-vpc.id
}

module "eks" {
  source = "./eks"
  sg_ids = module.sgs.security_group_public
  vpc_id = aws_vpc.demo-vpc.id
  subnet_ids = [aws_subnet.public_subnet-1.id,aws_subnet.public_subnet-2.id,
  aws_subnet.private_subnet-1.id,aws_subnet.private_subnet-2.id]
}