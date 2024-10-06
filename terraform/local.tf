# Declare variables for AWS credentials
variable "aws_default_region" {}
variable "aws_profile" {}
variable "environment" {}
variable "bucket_name" {}
variable "db_username" {}

locals {

    aws_default_region  = var.aws_default_region
    aws_profile = var.aws_profile
    environment = var.environment

    # Use this local for bucket name
    bucket_name = var.bucket_name

    # Use this local for database name
    db_username = var.db_username

    # Use this local for secrets name
    secrets_name = "rds-secret-de-challenge"
    
    # Network variables defined as locals
    cidr_block_vpc              = "10.0.0.0/16"
    cidr_block_public_subnet_a   = "10.0.1.0/24"
    cidr_block_public_subnet_b   = "10.0.2.0/24"
    cidr_block_public_route_table = "0.0.0.0/0"    

    common_tags = {        
        "Environment" = var.environment
        "Owner" = "arthurmf"
        "Project" = "data-engineering-assessment"
    }    
}
