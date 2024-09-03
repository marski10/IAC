module "aws-dev"{
    source = "../../infra"
    machine = "t2.micro"
    regiao_aws = "us-east-1"
    chave = "IAC-dev"
    security_name = "dev"
}

output "ip" {
  value= module.aws-dev.public_ip
}