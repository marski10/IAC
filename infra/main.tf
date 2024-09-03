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

resource "aws_instance" "app_server" {
  instance_type = var.machine
  ami           = "ami-066784287e358dad1"
  key_name      = var.chave
  security_groups = [var.security_name]
  tags = {
    Application = "MarcosDeploy"
  }
}

resource "aws_key_pair" "deployer"{
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}


 output "public_ip" {
  value = aws_instance.app_server.public_ip
}