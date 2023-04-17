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

