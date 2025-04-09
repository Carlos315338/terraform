
data "aws_vpc" "default" {
  default = true
}

# Subnets públicas existentes (reemplaza los IDs si ya los tienes)
data "aws_subnet" "public_a" {
  id = "subnet-0fe822fc968e1edd0" # zona A
}

data "aws_subnet" "public_b" {
  id = "subnet-054d96a95d204511f" # zona B
}

# Subnets privadas nuevas
resource "aws_subnet" "private_a" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.48.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.49.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-b"
  }
}

# Subnet Group para RDS
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "mysql-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "MySQL subnet group"
  }
}