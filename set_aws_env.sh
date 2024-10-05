#!/bin/bash

# Request input from the user
read -p "Enter your AWS Profile: " AWS_PROFILE
read -p "Enter your AWS Default Region: " AWS_DEFAULT_REGION
read -p "Enter the environment (e.g., dev, staging, production): " ENVIRONMENT

# Echo the export commands
echo "export AWS_PROFILE=$AWS_PROFILE"
echo "export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
echo "export ENVIRONMENT=$ENVIRONMENT"

echo "Environment variables have been configured!"