resource "aws_db_instance" "mysql" {
  identifier           = "mysql-db"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "basedatos" # nombre de la BD inicial
  username             = "admin"
  password             = "ClaveSegura123!" # pon algo más fuerte para producción
  publicly_accessible  = true
  skip_final_snapshot  = true

  db_subnet_group_name = var.subnet_group_name
  vpc_security_group_ids = ["sg-0f451decfe4c5cd99"] # ← reemplaza con el SG que permite tráfico 3306

  tags = {
    Name = "MySQL Usuario"
  }
}
