This Project Conntains Custom VPC creation and web server hosted on the custom VPC

VPC.tf
Custom VPC in the range 10.0.0.0 with 3 public subnet 2 private subnet, public subnets associated with public route table, private subnet associated with private route table, Internet gateway associated with public subnet.

Instance.tf
This file EC2 in a custom VPC network with the association Eip ,security group ,hosted wwith web server
