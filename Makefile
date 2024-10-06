# Define bash as the shell for Makefile
SHELL := /bin/bash

# Define variables
PYTHON := python3

# ------------- Environment Setup --------------

# Target to run the set_aws_env.sh script and set environment variables
env:
	@echo "Configuring environment variables..."
	@bash set_aws_env.sh  # Call the external script to set the environment variables

# Check if environment variables are properly set
check:
	@echo "Verifying environment variables..."
	@$(PYTHON) -c "from utils import check_environment_variables; check_environment_variables()"
	@echo "All environment variables are set!"

# ------------- Terraform Commands --------------

# Initialize Terraform
terraform-init:
	@echo "Initializing Terraform..."
	@cd terraform && terraform init

# Plan Terraform Infrastructure
terraform-plan:
	@echo "Planning Terraform infrastructure..."
	@cd terraform && terraform plan \
		-var="aws_profile=$(TF_VAR_AWS_PROFILE)" \
		-var="aws_default_region=$(TF_VAR_AWS_DEFAULT_REGION)" \
		-var="environment=$(TF_VAR_ENVIRONMENT)" \
		-var="bucket_name=$(TF_VAR_BUCKET_NAME)"

# Apply Terraform Infrastructure
terraform-apply:
	@echo "Applying Terraform infrastructure..."
	@cd terraform && terraform apply \
		-var="aws_profile=$(TF_VAR_AWS_PROFILE)" \
		-var="aws_default_region=$(TF_VAR_AWS_DEFAULT_REGION)" \
		-var="environment=$(TF_VAR_ENVIRONMENT)" \
		-var="bucket_name=$(TF_VAR_BUCKET_NAME)"

# Destroy Terraform Infrastructure
terraform-destroy:
	@echo "Destroying Terraform infrastructure..."
	@cd terraform && terraform destroy \
		-var="aws_profile=$(TF_VAR_AWS_PROFILE)" \
		-var="aws_default_region=$(TF_VAR_AWS_DEFAULT_REGION)" \
		-var="environment=$(TF_VAR_ENVIRONMENT)" \
		-var="bucket_name=$(TF_VAR_BUCKET_NAME)"

# ------------- Serverless Framework Commands --------------

# Deploy Serverless application
sls-deploy:
	@echo "Deploying Serverless application..."
	@cd src && serverless deploy --stage $(ENVIRONMENT)

# ------------- Default Setup and Cleanup --------------

# Full setup: configure environment, verify variables, initialize Terraform, plan, apply infrastructure, and deploy Serverless
all: env check terraform-init terraform-plan terraform-apply sls-deploy

# Clean up: destroy the Terraform-managed infrastructure
clean: terraform-destroy

# Prevent make from looking for files with these names
.PHONY: env check terraform-init terraform-plan terraform-apply terraform-destroy sls-deploy all clean