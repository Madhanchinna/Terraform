# creating instance, Security group
# old resources subnet, ami, vpc
# using our private subnet we are creating instance with new security group

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "demoec2" {
  ami               = "ami-0f3c9c466bb525749"
  instance_type     = "t2.micro"
  key_name          = "indra"
  availability_zone = "us-east-2a"
  user_data         = file("init-script.sh")
  subnet_id         = "subnet-0c658eabf69814f79"
  vpc_security_group_ids = [aws_security_group.security.id]
  
  source_dest_check = true
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
    }

  tags = {
    Name = "terraform-web-server"
  }
}

# creating security group in a perticular vpc

resource "aws_security_group" "security" {
  name        = "madhan_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0be17c15757aa429e"

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
}


