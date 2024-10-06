#!/bin/bash

# Request input from the user
read -p "Enter your AWS Profile: " AWS_PROFILE
read -p "Enter your AWS Default Region: " AWS_DEFAULT_REGION
read -p "Enter the environment (e.g., dev, staging, production): " ENVIRONMENT
read -p "Enter the default Bucket Name: " BUCKET_NAME
read -p "Enter the default Database User Name: " DB_USERNAME

# Export the environment variables immediately for the current session
export AWS_PROFILE="$AWS_PROFILE"
export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"
export ENVIRONMENT="$ENVIRONMENT"
export BUCKET_NAME="$BUCKET_NAME"
export DB_USERNAME="$DB_USERNAME"

# Export Terraform-specific environment variables
export TF_VAR_AWS_PROFILE="$AWS_PROFILE"
export TF_VAR_AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"
export TF_VAR_ENVIRONMENT="$ENVIRONMENT"
export TF_VAR_BUCKET_NAME="$BUCKET_NAME"
export TF_VAR_DB_USERNAME="$DB_USERNAME"

# Append to ~/.bashrc to persist variables for future sessions
echo "export AWS_PROFILE=\"$AWS_PROFILE\"" >> ~/.bashrc
echo "export AWS_DEFAULT_REGION=\"$AWS_DEFAULT_REGION\"" >> ~/.bashrc
echo "export ENVIRONMENT=\"$ENVIRONMENT\"" >> ~/.bashrc
echo "export BUCKET_NAME=\"$BUCKET_NAME\"" >> ~/.bashrc
echo "export DB_USERNAME=\"$DB_USERNAME\"" >> ~/.bashrc
echo "export TF_VAR_AWS_PROFILE=\"$AWS_PROFILE\"" >> ~/.bashrc
echo "export TF_VAR_AWS_DEFAULT_REGION=\"$AWS_DEFAULT_REGION\"" >> ~/.bashrc
echo "export TF_VAR_ENVIRONMENT=\"$ENVIRONMENT\"" >> ~/.bashrc
echo "export TF_VAR_BUCKET_NAME=\"$BUCKET_NAME\"" >> ~/.bashrc
echo "export TF_VAR_DB_USERNAME=\"$DB_USERNAME\"" >> ~/.bashrc

# Source the .bashrc file to make the changes take effect in the current session
source ~/.bashrc

echo "Environment variables have been configured and persisted to .bashrc!"