resource "aws_db_instance" "rds_dev" {
  allocated_storage    = 40                             
  storage_type         = "gp2"                          
  engine               = "sqlserver-ee"                 
  engine_version       = "15.00.4395.2.v1"             
  instance_class       = "db.t3.xlarge"                 
  username             = "labrds"                        
  password             = ""            
  license_model         = "license-included"
  identifier            = "lab-dev"      
  vpc_security_group_ids = [var.vpc_sg]              
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name  
  publicly_accessible = true
  skip_final_snapshot = true
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids      
  description = "Subnet group for RDS SQL Server"
}

output "rds_endpoint" {
  value = aws_db_instance.rds_dev.endpoint               
}
