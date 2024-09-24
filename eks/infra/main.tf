
terraform {
  
  required_version = ">= 1.6.6"
  
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = vars.region
}


resource "aws_vpc" "eks_vpc" {

    cidr_block = vars.cidrip4
    ipv6_cidr_block = vars.cidrip6
    instance_tenancy = "default"
  
    tags = {
        Name = "EKS_VPC"
    }

}
