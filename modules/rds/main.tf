resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0.36"
  instance_class       = "db.t3.micro"
  username             = "rdsadmin"
  password             = "ExpenseApp123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  component = "rds"
}
resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "mysql8.0"
}


