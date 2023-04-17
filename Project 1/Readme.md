This Project Contains Three Tire Architecturein a custom VPC, 

hosted Apache web server in public subnet, Php app and DB in private subnet the custom VPC

providers.tf
This file contains in which region our resources to create.

VPC.tf
Custom VPC in the range 10.0.0.0 with 3 public subnet 6 private subnet, public subnets associated with web route table, private subnet associated with app and db route table, Internet gateway associated with public subnet.

ec2.tf
1.This file ec2 resources ami is maped with the region
2. Security groups are associate with the instance

variables.tf
All the variables are declred in this file


