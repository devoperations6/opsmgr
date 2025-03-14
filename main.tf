terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}
#aws provider
provider "aws" {
    region = "us-east-1"
  
}
#vpc creation
resource "aws_vpc" "ohiovpc" {
 cidr_block = "10.0.0.0/16" 
}
#subnet creation
resource "aws_subnet" "ohiosubnet" {
  vpc_id = aws_vpc.ohiovpc.id
  cidr_block = "10.0.0.1.0/24"
  tags = {
    Name = ohiosubnet
  }
}
# Data source to fetch the AMI ID
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
resource "aws_instance" "webserver" {
  ami = "data.aws_ami.amazon_linux_2.id"
  instance_type = "t2.micro"
  tags = {
    Name = "webserver"
  }
   
  }
  
}