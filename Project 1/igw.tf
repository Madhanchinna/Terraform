# AWS Internet gatway resourec creation
resource "aws_internet_gateway" "EC2InternetGateway" {
  vpc_id = aws_vpc.my_vpc.id

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