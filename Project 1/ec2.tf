resource "aws_instance" "myec2" {
  ami                    = data.aws_ami.web_ami.id
  instance_type          = "t2.micro"
  key_name               = "ec2_key"
  user_data              = file("init-script.sh")
  subnet_id              = aws_subnet.EC2Subnet1.id
  vpc_security_group_ids = [aws_security_group.security_1.id]

  tags = {
    Name = "Apache_web_server"
  }

  # Instance root volume
  source_dest_check = true
  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
}

# Data block to Fetch Latest AMI from the Region
data "aws_ami" "web_ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Private instance

resource "aws_instance" "ec2_1" {
  ami                    = data.aws_ami.web_ami.id
  instance_type          = "t2.micro"
  key_name               = "ec2_key"
  subnet_id              = aws_subnet.EC2Subnet4.id
  vpc_security_group_ids = [aws_security_group.security_2.id]

  tags = {
    Name = "private_instance"
  }

  # Instance root volume
  source_dest_check = true
  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
}

# creating security group with public access for web application

resource "aws_security_group" "security_1" {
  name        = "web_sg"
  description = "Allow All public traffic"
  vpc_id      = aws_vpc.EC2VPC.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.client_ip]
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = [var.client_ip]
    }
  }

  tags = {
    Name = "web_sg"
  }
}

# This security group will access web to app instance (Bastion host)
resource "aws_security_group" "security_2" {
  name        = "app_sg"
  description = "Allow All public traffic vaya publicly accessable instance"
  vpc_id      = aws_vpc.EC2VPC.id

  ingress {
    security_groups = [aws_security_group.security_1.id]
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
  }

  ingress {
    security_groups = [aws_security_group.security_1.id]
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
  }

  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }
  tags = {
    Name = "app_sg"
  }
}

resource "aws_security_group" "security_3" {
  name        = "database_sg"
  description = "Allow All public traffic vaya publicly accessable instance"
  vpc_id      = aws_vpc.EC2VPC.id

  ingress {
    security_groups = [aws_security_group.security_2.id]
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
  }

  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }

  tags = {
    Name = "db_sg"
  }
}