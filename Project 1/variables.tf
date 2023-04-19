#variables
# Mention VPC region that you want to create
variable "vpc_region" {
  default = "ap-south-1"
}

# Mention VPC CIDR block that you want to create
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet1" {
  type    = list(any)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet2" {
  type    = list(any)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "subnet3" {
  type    = list(any)
  default = ["10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
}

# Mention the availability zone without zone name like "ap-south"
# please mention the availability zone on vpc.tf file like "${var.vpc_az}a" hear a is the avilability zone as like "ap-south-1a"
variable "vpc_az" {
  type    = list(any)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "client_ip" {
  default = "0.0.0.0/0"
}

# Ingress ports are mention in the Dynamic block
variable "ingress_rules" {
  type        = list(number)
  description = "list of ingress port"
  default     = [80, 22, 8000]
}

# Egress ports are mention in the Dynamic block
variable "egress_rules" {
  type        = list(number)
  description = "list of egress ports"
  default     = [0]
}