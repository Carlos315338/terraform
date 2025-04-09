resource "aws_ecr_repository" "cosmeticos-belleza-infinita" {
  name                 = "cosmeticos-belleza-infinita"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name = "cosmeticos-belleza-infinita"
  }
}
