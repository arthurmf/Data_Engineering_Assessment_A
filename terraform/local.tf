# Declare variables
variable "aws_region" {}
variable "aws_profile" {}
variable "environment" {}

locals {
    aws_region  = var.aws_region
    aws_profile = var.aws_profile
    environment = var.environment

    # AWS S3 Variables
    bucket_name = "bucket-de-challenge-20241005"
    
    # Network variables defined as locals
    cidr_block_vpc              = "10.0.0.0/16"
    cidr_block_public_subnet_a   = "10.0.1.0/24"
    cidr_block_public_subnet_b   = "10.0.2.0/24"
    cidr_block_public_route_table = "0.0.0.0/0"    

    common_tags = {        
        "Environment" = local.environment
        "Owner" = "arthurmf"
        "Project" = "data-engineering-assessment"
    }    
}
