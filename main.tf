provider "aws" {
  region = "us-east-2"
}

module "cognito" {
  source = "./cognito"
}

module "ecr" {
  source = "./ecr"
}



module "rds" {
  source = "./rds"
}

module "budget" {
  source = "./budget"
}
