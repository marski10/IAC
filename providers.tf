terraform {
  required_version = ">= 1.9.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0"
    }

    local = { 
      source = "hashicorp/local"
      version = ">= 2.5.2"
    }
  }
  backend "s3" {
    bucket = "terraform-states-lab-marcos"
    key = "terraform.tfstate"
    region = "us-east-1"

  }

}

provider "kubernetes" {
  config_path = "/workspaces/go-3/IAC/kubeconfig"
}

provider "aws" {

  region = "us-east-1"

} 
