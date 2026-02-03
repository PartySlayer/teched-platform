# data "terraform_remote_state" "global" {
#   backend = "s3"
#   config = {
#     bucket = "terraform-state"
#     key    = "global/ecr/terraform.tfstate"
#     region = "eu-west-1"
#   }
# }

#image = "${data.terraform_remote_state.global.outputs.auth_repository_url}:dev"

module "networking" {
  source = "../../modules/networking"

  cidr            = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]
  #enable_nat      = true
}

module "alb" {
  source = "../../modules/alb"

  vpc_id          = module.networking.vpc_id
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = module.networking.public_subnet_ids
  certificate_arn = var.certificate_arn
}

module "ecs_cluster" {
  source = "../../modules/ecs-cluster"
}

module "auth_db" {
  source = "../../modules/rds"

  db_identifier = "${var.project_name}-auth-postgres"
  db_name       = "authdb"
  vpc_id        = module.networking.vpc_id
  subnet_ids    = module.networking.private_subnet_ids

  allowed_security_group_ids = [
    module.networking.default_security_group_id
  ]

}

module "learn_db" {
  source = "../../modules/rds"

  db_identifier = "${var.project_name}-learn-postgres"
  db_name       = "learndb"
  vpc_id        = module.networking.vpc_id
  subnet_ids    = module.networking.private_subnet_ids

  allowed_security_group_ids = [
    module.networking.default_security_group_id
  ]
}

