This Project Contains Three Tire Architecturein a custom VPC, 

hosted Apache web server in public subnet, Php app and DB in private subnet the custom VPC

providers.tf
This file contains in which region our resources to create.

VPC.tf
Custom VPC in the range 10.0.0.0 with 3 public subnet 6 private subnet, public subnets associated with web route table, private subnet associated with app and db route table, Internet gateway associated with public subnet.

ec2.tf
This file ec2 resources ami is maped with the instance resources

Security_groups.tf
Security groups are associate with the instance

variables.tf
All the variables are declred in this file

Resources need to be created / installed :
Custom VPC

2 Subnets (Public)

1 Subnet (Private)

2 EC2 Instances

Security Group

Elastic IP

NAT Gateway

Internet Gateway

Route Table

Application Load Balancer

Apache Webserver


