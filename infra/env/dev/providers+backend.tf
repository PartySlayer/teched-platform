terraform {

  backend "s3" {
    bucket         = "teched-platform-xx-tf-state" # per ora hardcoded
    key            = "envs/dev/terraform.tfstate"  # path per tfstate DEV
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "teched-platform-xx-tf-locks" # per ora hardcoded
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}