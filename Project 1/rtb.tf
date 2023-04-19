# Route table for web 
resource "aws_route_table" "RouteTable1" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EC2InternetGateway.id
  }

  tags = {
    Name = "web_route_table"
  }
}

# Route Table for app
resource "aws_route_table" "RouteTable2" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id

  }

  tags = {
    Name = "app_route_table"
  }
}

# Route Table for db 
resource "aws_route_table" "RouteTable3" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "db_route_table"
  }
}

# Associating subnets with web route tables

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation1" {
  route_table_id = aws_route_table.RouteTable1.id
  subnet_id      = aws_subnet.EC2Subnet1[count.index].id
  count          = 3
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation2" {
  route_table_id = aws_route_table.RouteTable2.id
  subnet_id      = aws_subnet.EC2Subnet2[count.index].id
  count          = 3
}

resource "aws_route_table_association" "EC2SubnetRouteTableAssociation3" {
  route_table_id = aws_route_table.RouteTable3.id
  subnet_id      = aws_subnet.EC2Subnet3[count.index].id
  count          = 3
}