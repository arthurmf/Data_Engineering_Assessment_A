#!/bin/bash

# Request input from the user
read -p "Enter your AWS Profile: " AWS_PROFILE
read -p "Enter your AWS Default Region: " AWS_DEFAULT_REGION
read -p "Enter the environment (e.g., dev, staging, production): " ENVIRONMENT

# Export the environment variables
export AWS_PROFILE="$AWS_PROFILE"
export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"
export ENVIRONMENT="$ENVIRONMENT"

# Save the environment variables to a file if you want to persist them
echo "export AWS_PROFILE=\"$AWS_PROFILE\"" >> ~/.bashrc
echo "export AWS_DEFAULT_REGION=\"$AWS_DEFAULT_REGION\"" >> ~/.bashrc
echo "export ENVIRONMENT=\"$ENVIRONMENT\"" >> ~/.bashrc

# Source the .bashrc to apply the changes immediately
source ~/.bashrc

echo "Environment variables have been configured!"