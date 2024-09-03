module "aws-prod"{
    source = "../../infra"
    machine = "t2.micro"
    regiao_aws = "us-east-1"
    chave = "IaC-Prod"
    security_name = "prod"
}

output "ip" {
  value= module.aws-prod.public_ip
}