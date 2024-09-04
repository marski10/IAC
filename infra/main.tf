terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"

    }
  }
  required_version = ">= 1.2.0"

}


provider "aws" {
  region  = var.regiao_aws
  profile = "default"
}



resource "aws_default_subnet" "subnet_zone_a"{

  availability_zone  = ["${var.regiao_aws}b"]

}

resource "aws_default_subnet" "subnet_zone_b"{

  availability_zone  = ["${var.regiao_aws}b"]

}

resource "aws_alb" "loadbalance"{

  internal = false
  subnets = [aws_default_subnet.subnet_zone_a.id,aws_default_subnet.subnet_zone_b.id]


}


resource "aws_launch_template" "template" {
  instance_type = var.machine
  image_id           = "ami-066784287e358dad1"
  key_name      = var.chave
  security_group_names = [var.security_name]
  tags = {
    Application = "MarcosDeploy"
  }
  user_data = filebase64("ansible.sh")
  
}

resource "aws_key_pair" "deployer"{
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}


resource aws_autoscaling_group "group" {
  min_size = var.minsize
  max_size = var.maxsize
  name = var.name_group
  availability_zones = ["${var.regiao_aws}b","${var.regiao_aws}a"]
  launch_template{
    id = aws_launch_template.template.id
    version = "$Latest"

  }




