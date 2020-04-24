resource "aws_vpc" "eks-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = tomap({
     "Name" = "${var.env_prefix}-vpc",
     "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_subnet" "eks-subnet-1" {
    vpc_id = aws_vpc.eks-vpc.id
    cidr_block = var.subnet_cidr_block 
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true
    tags = tomap({
       "Name" = "${var.env_prefix}-subnet-1",
       "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_internet_gateway" "eks-gateway" {
  vpc_id = aws_vpc.eks-vpc.id
  tags = {
    Name = "${var.env_prefix}-gateway"
  }
}

resource "aws_route_table" "eks-route-table" {
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-gateway.id
  }
}

resource "aws_route_table_association" "eks-route-table-assos" {
  count = 2
  subnet_id      = aws_subnet.eks-subnet-1.id
  route_table_id = aws_route_table.eks-route-table.id
}

