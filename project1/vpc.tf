resource "aws_vpc" "EC2VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "my_vpc"
  }
}


# 3 subnet for Public Access 2 subnet private

resource "aws_subnet" "EC2Subnet" {
    availability_zone = "us-east-2a"
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.EC2VPC.id
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet2" {
    availability_zone = "us-east-2b"
    cidr_block = "10.0.3.0/24"
    vpc_id = aws_vpc.EC2VPC.id
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet3" {
    availability_zone = "us-east-2b"
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.EC2VPC.id
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet4" {
    availability_zone = "us-east-2a"
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.EC2VPC.id
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet5" {
    availability_zone = "us-east-2c"
    cidr_block = "10.0.5.0/24"
    vpc_id = aws_vpc.EC2VPC.id
    map_public_ip_on_launch = true
}


# Route table for Pubic 
resource "aws_route_table" "EC2RouteTable1" {
  vpc_id = aws_vpc.EC2VPC.id
  tags = {
    Name = "public_route_table"
  }
}
# Route Table for private 
resource "aws_route_table" "EC2RouteTable2" {
  vpc_id = aws_vpc.EC2VPC.id
  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation" {
    route_table_id = aws_route_table.EC2RouteTable1.id
    subnet_id = aws_subnet.EC2Subnet.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation2" {
    route_table_id = aws_route_table.EC2RouteTable1.id
    subnet_id = aws_subnet.EC2Subnet4.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation3" {
    route_table_id = aws_route_table.EC2RouteTable1.id
    subnet_id = aws_subnet.EC2Subnet5.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation4" {
    route_table_id = aws_route_table.EC2RouteTable2.id
    subnet_id = aws_subnet.EC2Subnet2.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation5" {
    route_table_id = aws_route_table.EC2RouteTable2.id
    subnet_id = aws_subnet.EC2Subnet3.id
}

# AWS Internet gatway resourec creation
resource "aws_internet_gateway" "EC2InternetGateway" {
    vpc_id = aws_vpc.EC2VPC.id

    tags = {
        Name = "my_ig"
    }   
}

# Aws IGW associate route to route table
resource "aws_route" "EC2Route" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EC2InternetGateway.id
    route_table_id = aws_route_table.EC2RouteTable1.id
}

