# Region belongs to VPC created
provider "aws" {
  region = var.vpc_region
}

resource "aws_vpc" "EC2VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "my_vpc"
  }
}

# 3 Tire Architecture
#3 AZ each AZ contains 3 subnet
# A Availability zone contains web,app,db

resource "aws_subnet" "EC2Subnet1" {
  availability_zone       = "${var.vpc_az}a"
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = true

  tags = {
    Name = "web_${var.vpc_az}a"
  }
}

resource "aws_subnet" "EC2Subnet2" {
  availability_zone       = "${var.vpc_az}b"
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = true

  tags = {
    Name = "web_${var.vpc_az}b"
  }
}

resource "aws_subnet" "EC2Subnet3" {
  availability_zone       = "${var.vpc_az}c"
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = true

  tags = {
    Name = "web_${var.vpc_az}c"
  }
}

resource "aws_subnet" "EC2Subnet4" {
  availability_zone       = "${var.vpc_az}a"
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = false

  tags = {
    Name = "app_${var.vpc_az}a"
  }
}

resource "aws_subnet" "EC2Subnet5" {
  availability_zone       = "${var.vpc_az}b"
  cidr_block              = "10.0.4.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = false

  tags = {
    Name = "app_${var.vpc_az}b"
  }
}

resource "aws_subnet" "EC2Subnet6" {
  availability_zone       = "${var.vpc_az}c"
  cidr_block              = "10.0.5.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = false

  tags = {
    Name = "app_${var.vpc_az}c"
  }
}

resource "aws_subnet" "EC2Subnet7" {
  availability_zone       = "${var.vpc_az}a"
  cidr_block              = "10.0.6.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = false

  tags = {
    Name = "db_${var.vpc_az}a"
  }
}

resource "aws_subnet" "EC2Subnet8" {
  availability_zone       = "${var.vpc_az}b"
  cidr_block              = "10.0.7.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = false

  tags = {
    Name = "db_${var.vpc_az}b"
  }
}

resource "aws_subnet" "EC2Subnet9" {
  availability_zone       = "${var.vpc_az}c"
  cidr_block              = "10.0.8.0/24"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = false

  tags = {
    Name = "db_${var.vpc_az}c"
  }
}

# Route table for web 
resource "aws_route_table" "RouteTable1" {
  vpc_id = aws_vpc.EC2VPC.id

  tags = {
    Name = "web_route_table"
  }
}

# Route Table for app
resource "aws_route_table" "RouteTable2" {
  vpc_id = aws_vpc.EC2VPC.id

  tags = {
    Name = "app_route_table"
  }
}

# Route Table for private 
resource "aws_route_table" "RouteTable3" {
  vpc_id = aws_vpc.EC2VPC.id

  tags = {
    Name = "db_route_table"
  }
}
# Associating subnets with web route table

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation" {
  route_table_id = aws_route_table.RouteTable1.id
  subnet_id      = aws_subnet.EC2Subnet1.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation2" {
  route_table_id = aws_route_table.RouteTable1.id
  subnet_id      = aws_subnet.EC2Subnet2.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation3" {
  route_table_id = aws_route_table.RouteTable1.id
  subnet_id      = aws_subnet.EC2Subnet3.id
}

# Associating subnets with app route table
resource "aws_route_table_association" "EC2SubnetRouteTableAssociation4" {
  route_table_id = aws_route_table.RouteTable2.id
  subnet_id      = aws_subnet.EC2Subnet4.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation5" {
  route_table_id = aws_route_table.RouteTable2.id
  subnet_id      = aws_subnet.EC2Subnet5.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation6" {
  route_table_id = aws_route_table.RouteTable2.id
  subnet_id      = aws_subnet.EC2Subnet6.id
}

# Associating subnets with db route table
resource "aws_route_table_association" "EC2SubnetRouteTableAssociation7" {
  route_table_id = aws_route_table.RouteTable3.id
  subnet_id      = aws_subnet.EC2Subnet7.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation8" {
  route_table_id = aws_route_table.RouteTable3.id
  subnet_id      = aws_subnet.EC2Subnet8.id
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation9" {
  route_table_id = aws_route_table.RouteTable3.id
  subnet_id      = aws_subnet.EC2Subnet9.id
}

# AWS Internet gatway resourec creation
resource "aws_internet_gateway" "EC2InternetGateway" {
  vpc_id = aws_vpc.EC2VPC.id

  tags = {
    Name = "my_ig"
  }
}

# Aws IGW associate with route table1 to allow public internet
resource "aws_route" "EC2Route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.EC2InternetGateway.id
  route_table_id         = aws_route_table.RouteTable1.id
}

