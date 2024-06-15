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