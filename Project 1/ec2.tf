resource "aws_instance" "myec2" {
  ami                         = data.aws_ami.web_ami.id
  instance_type               = "t2.micro"
  key_name                    = "ec2_key"
  user_data                   = file("init-script.sh")
  subnet_id                   = aws_subnet.EC2Subnet1[count.index].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.security_1.id]
  count                       = 2

  tags = {
    Name = "web_server"
  }

  provisioner "file" {
    source      = "./ec2_key.pem"
    destination = "/home/ec2-user/ec2_key.pem"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./ec2_key.pem")
    }
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
  subnet_id              = aws_subnet.EC2Subnet2[0].id
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

/*
# Data block to Fetch Latest AMI from the Region
data "aws_ami" "web_ami_1" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]

  filter {
    name   = "name"
    values = ["RHEL-9.*"]
  }
}

*/
