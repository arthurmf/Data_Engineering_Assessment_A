# Importing list of AZs
data "aws_availability_zones" "aws_az" {
  state = "available"
}