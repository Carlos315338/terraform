variable "vpc_id" {
  description = "VPC ID donde desplegar ECS"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR de la VPC para restringir el tráfico interno"
  type        = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "image_uri" {
  description = "La URI de la imagen en ECR"
  type        = string
}