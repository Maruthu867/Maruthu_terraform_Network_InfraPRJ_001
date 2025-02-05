terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {

access_key = "***********"
secret_key = "***********"
region = "ap-south-1"
  
}

resource "aws_vpc" "Mainvpc" {

    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "Mainvpc_001"
    }
  
}

resource "aws_subnet" "pubsub" {
    vpc_id            = aws_vpc.Mainvpc.id
    availability_zone = "ap-south-1a"
    cidr_block = "10.0.1.0/24"

    tags = {
      Name = "PUBSUb-001"
    }
}

resource "aws_subnet" "prisub" {
    vpc_id            = aws_vpc.Mainvpc.id
    availability_zone = "ap-south-2a"
    cidr_block = "10.0.2.0/24"

    tags = {
      Name= "PRISUB-001"
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Mainvpc.id

  tags = {
    Name = "MainIGW"
  }
}

resource "aws_eip" "myeip" {
    
    tags = {
      name = "example name "
    }
}

resource "aws_nat_gateway" "NatTF" {
  allocation_id = aws_eip.myeip.id
  subnet_id = aws_subnet.pubsub.id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.Mainvpc.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "pubrt"
  }
}

resource "aws_route_table_association" "pubrtass" {
  subnet_id      = aws_subnet.pubsub.id
  route_table_id = aws_route_table.pubrt.id
}
resource "aws_route_table" "prirt" {
  vpc_id = aws_vpc.Mainvpc.id

  route {
    cidr_block = "10.0.2.0/24"
    gateway_id = aws_nat_gateway.NatTF.id
  }

  tags = {
    Name = "prirt"
  }
}

resource "aws_route_table_association" "prirtass" {
  subnet_id      = aws_subnet.prisub.id
  route_table_id = aws_route_table.prirt.id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Mainvpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.Mainvpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_instance" "Ec2_1" {

    ami = "00bb6a80f01f03502"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.prisub.id

  
}

resource "aws_instance" "Ec2_2" {

    ami = "00bb6a80f01f03502"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.pubsub.id

  
}