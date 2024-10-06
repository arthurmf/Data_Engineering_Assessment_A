#!/bin/bash

# Remove lines containing the environment variables from ~/.bashrc
sed -i '/AWS_PROFILE=/d' ~/.bashrc
sed -i '/AWS_DEFAULT_REGION=/d' ~/.bashrc
sed -i '/ENVIRONMENT=/d' ~/.bashrc
sed -i '/BUCKET_NAME=/d' ~/.bashrc
sed -i '/TF_VAR_AWS_PROFILE=/d' ~/.bashrc
sed -i '/TF_VAR_AWS_DEFAULT_REGION=/d' ~/.bashrc
sed -i '/TF_VAR_ENVIRONMENT=/d' ~/.bashrc
sed -i '/TF_VAR_BUCKET_NAME=/d' ~/.bashrc

# Unset the variables from the current session
unset AWS_PROFILE
unset AWS_DEFAULT_REGION
unset ENVIRONMENT
unset BUCKET_NAME
unset TF_VAR_AWS_PROFILE
unset TF_VAR_AWS_DEFAULT_REGION
unset TF_VAR_ENVIRONMENT
unset TF_VAR_BUCKET_NAME

# Source the ~/.bashrc to apply changes (no longer needed in this case)
source ~/.bashrc

echo "Environment variables have been removed from ~/.bashrc and unset in the current session."
