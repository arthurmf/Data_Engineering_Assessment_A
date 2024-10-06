# Cloud Provider info
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile                 = local.aws_profile
  region                  = local.aws_default_region
  shared_credentials_file = "~/.aws/credentials"
}