# ========== Create a vpc ==========
resource "aws_vpc" "aws_vpc" {
  cidr_block = local.cidr_block_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(local.common_tags, {"Name" = "vpc_de_challenge"})
}

# ========== Create an internet gateway - IGW ==========
resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = merge(local.common_tags, {"Name" = "igw_de_challenge"})
}

# ========== Create two public Subnets ==========

# Public Subnet a
resource "aws_subnet" "public_subnet_a" {
  vpc_id           = aws_vpc.aws_vpc.id  
  cidr_block       = local.cidr_block_public_subnet_a
  availability_zone = data.aws_availability_zones.aws_az.names[0]
  tags = merge(local.common_tags, {"Name" = "public_subnet_a"})
}

# Public Subnet b
resource "aws_subnet" "public_subnet_b" {
  vpc_id           = aws_vpc.aws_vpc.id
  cidr_block       = local.cidr_block_public_subnet_b
  availability_zone = data.aws_availability_zones.aws_az.names[1]
  tags = merge(local.common_tags, {"Name" = "public_subnet_b"})
}

# ========== Create the route tables ==========

# Route table for public subnet a 
resource "aws_route_table" "public_subnet_route_table_a" {
  vpc_id = aws_vpc.aws_vpc.id

  # Maps internet traffic to the internet gateway
  route {
    cidr_block = local.cidr_block_public_route_table
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }

  tags = merge(local.common_tags, {"Name" = "rt_public_subnet_a"})
}

# Route table for public subnet b
resource "aws_route_table" "public_subnet_route_table_b" {
  vpc_id = aws_vpc.aws_vpc.id

  # Maps internet traffic to the internet gateway
  route {
    cidr_block = local.cidr_block_public_route_table
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }

  tags = merge(local.common_tags, {"Name" = "rt_public_subnet_b"})
}

# ========== Subnets association with route tables ==========

# Associate public subnet a to its route table a
resource "aws_route_table_association" "public_subnet_route_table_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_subnet_route_table_a.id
}

# Associate public subnet b to its route table b
resource "aws_route_table_association" "public_subnet_route_table_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_subnet_route_table_b.id
}