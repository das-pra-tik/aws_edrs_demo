# https://discuss.hashicorp.com/t/creating-aws-resources-with-terraform-across-multiple-regions/25010/2
# https://developer.hashicorp.com/terraform/language/meta-arguments/module-providers
data "aws_availability_zones" "available_azs" { state = "available" }

# Create non-default VPC 
resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    Name = "aws-vpc"
  }
}

# Create non-default Internet Gateway
resource "aws_internet_gateway" "aws_igw" {
  depends_on = [aws_vpc.aws_vpc]
  vpc_id     = aws_vpc.aws_vpc.id
  tags = {
    Name = "IGW"
  }
}

resource "aws_subnet" "public_subnet" {
  depends_on              = [aws_vpc.aws_vpc]
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc-PublicSubnet"
    Tier = "vpc-Public"
  }
}

resource "aws_subnet" "private_subnet" {
  depends_on              = [aws_vpc.aws_vpc]
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "vpc-PrivateSubnet"
    Tier = "vpc-Private"
  }
}

resource "aws_route_table" "public-rt" {
  depends_on = [aws_subnet.public_subnet]
  vpc_id     = aws_vpc.aws_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_igw.id
  }
  tags = {
    Name = "vpc-PublicRT"
  }
}

resource "aws_route_table_association" "public-rt-assoc" {
  depends_on     = [aws_subnet.public_subnet, aws_route_table.public-rt]
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table" "private-rt" {
  depends_on = [aws_subnet.private_subnet]
  vpc_id     = aws_vpc.aws_vpc.id
  tags = {
    Name = "vpc-PrivateRT"
  }
}

resource "aws_route_table_association" "private-rt-assoc" {
  depends_on     = [aws_subnet.private_subnet, aws_route_table.private-rt]
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private-rt.id
}
