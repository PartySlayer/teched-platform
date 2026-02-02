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
  azs             = ["eu-west-1a", "eu-west-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]
}
