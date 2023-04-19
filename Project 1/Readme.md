This Project Contains Three Tire Architecturein a custom VPC, 

Hosted Apache web server in public subnet, Php app and DB in private subnet the custom VPC

providers.tf
  This file contains in which region our resources to create.

VPC.tf
  Custom VPC in the range 10.0.0.0 with 3 public subnet 6 private subnet, public subnets associated with web route table, private subnet associated with app and db route table, Internet gateway associated with public subnet.

ec2.tf
  This file ec2 resources ami is maped with the instance resources

sg.tf
  Security groups are associate with the instance

variables.tf
  All the variables are declred in this file

Resources need to be created / installed :
Custom VPC
  3 Subnets (Public)
  3 Subnet (Private)
  3 Subnet (db)

Instances
  2 EC2 Instances for web application
  1 in private subnet 


Security Group
  1. Public SG -- Allows port 80 ,22 to allow to web server ()
  2. private SG -- Allows port 22 throuth public SG
  3. ALB SG -- Allows port 80 to access web server by End user 


Elastic IP
  Elastic Ip is attached with NAT Gateway

NAT Gateway
  Created in public subnet Attached with private routeTable

Internet Gateway
  IGW attached with Public Route table

Route Table
  public route table
  private route table

Application Load Balancer
  web server are load balanced by ALB 

Apache Webserver
  Web server installed by bash Script


