resource "local_file" "marcos"{
    filename = "marcos.txt"
    content = var.MARCOS   

}

variable "MARCOS" {
  
}

variable "AURELIO"{}

data "local_file" "marcos_content" {
    filename = "marcos.txt"

}

output "teste" {

    value=data.local_file.marcos_content.content_base64

}

output "saida" {
    value = local_file.marcos.id
}