provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./vpc"
}

module "cognito" {
  source = "./cognito"
}

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source                      = "./ecs"
  vpc_id                      = module.vpc.vpc_id
  vpc_cidr_block              = module.vpc.vpc_cidr_block
  subnet_ids                  = [module.vpc.private_subnet_a, module.vpc.private_subnet_b]
  image_uri                   = "public.ecr.aws/docker/library/alpine:latest"
}

module "rds" {
  source                 = "./rds"
  subnet_group_name      = module.vpc.rds_subnet_group_name
}

module "budget" {
  source = "./budget"
}
