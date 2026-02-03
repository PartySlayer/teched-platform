terraform {

  backend "s3" { # non ti scordare che è obbligatorio hardcode qui
    bucket         = "teched-platform-xx-tf-state"
    key            = "shared/route53/terraform.tfstate" # path per tfstate route53
    region         = "eu-west-1"                    # non ti scordare 
    encrypt        = true
    dynamodb_table = "teched-platform-xx-tf-locks" # non ti scordare
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
