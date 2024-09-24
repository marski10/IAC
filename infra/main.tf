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

  availability_zone  = "${var.regiao_aws}a"

}

resource "aws_default_subnet" "subnet_zone_b"{

  availability_zone  = "${var.regiao_aws}b"

}

resource "aws_alb" "loadbalance"{

  internal = false
  subnets = [aws_default_subnet.subnet_zone_a.id,aws_default_subnet.subnet_zone_b.id]


}


resource "aws_lb_target_group" "aws_target"{

  port = "8000"
  protocol = "HTTP"
  name = "marcos-deploy"
  vpc_id = aws_default_vpc.vpc_deploy.id
}



resource "aws_default_vpc" "vpc_deploy" {
 
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

output "verify" {
 value =  "${var.regiao_aws}b"
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
 target_group_arns = [aws_lb_target_group.aws_target.arn]
}

resource "aws_lb_listener" "deploy_listener" {
  load_balancer_arn = aws_alb.loadbalance.arn
  port = "8000"
  protocol = "HTTP"
  default_action{
    type = "forward"
    target_group_arn = aws_lb_target_group.aws_target.arn

  }


}
