resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "mysql-subnet-group"
  subnet_ids = ["subnet-0fe822fc968e1edd0", "subnet-054d96a95d204511f"] # ← reemplaza con tus subnets

  tags = {
    Name = "MySQL subnet group"
  }
}

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

  db_subnet_group_name = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = ["sg-0f451decfe4c5cd99"] # ← reemplaza con el SG que permite tráfico 3306

  tags = {
    Name = "MySQL Usuario"
  }
}
