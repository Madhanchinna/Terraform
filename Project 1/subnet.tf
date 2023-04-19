resource "aws_subnet" "EC2Subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  availability_zone       = var.vpc_az[count.index]
  cidr_block              = var.subnet1[count.index]
  map_public_ip_on_launch = true
  count                   = 3

  tags = {
    Name = "Web_${var.vpc_az[count.index]}"
  }
}

resource "aws_subnet" "EC2Subnet2" {
  availability_zone       = var.vpc_az[count.index]
  cidr_block              = var.subnet2[count.index]
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = false
  count                   = 3

  tags = {
    Name = "app_${var.vpc_az[count.index]}"
  }
}

resource "aws_subnet" "EC2Subnet3" {
  availability_zone       = var.vpc_az[count.index]
  cidr_block              = var.subnet3[count.index]
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = false
  count                   = 3

  tags = {
    Name = "db_${var.vpc_az[count.index]}"
  }
}
