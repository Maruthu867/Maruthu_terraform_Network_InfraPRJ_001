# Maruthu_terraform_Network_InfraPRJ_001
This Terraform code creates an AWS VPC with public and private subnets, route tables, an Internet Gateway, a NAT Gateway, and two EC2 instances. The public subnet has internet access, while the private subnet uses the NAT Gateway. Run terraform init, terraform plan, and terraform apply to deploy. Ideal for secure, scalable AWS setups. 🚀

Terraform AWS VPC Setup
This repository contains Terraform code to provision an AWS Virtual Private Cloud (VPC) along with essential networking components. The infrastructure includes:

VPC: A custom Virtual Private Cloud
Subnets: One public and one private subnet
Route Tables: Separate public and private route tables
Internet Gateway: For outbound internet access from public instances
NAT Gateway: For secure outbound internet access from private instances
EC2 Instances: One instance in the public subnet and one in the private subnet
Usage
Clone the repository
Update the terraform.tfvars file with your desired configurations
Run terraform init, terraform plan, and terraform apply to deploy the infrastructure
This setup is ideal for hosting applications that require both public and private compute resources while maintaining network security best practices. 🚀

