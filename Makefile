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
		-var="bucket_name=$(TF_VAR_BUCKET_NAME)" \
		-var="db_username=$(TF_VAR_DB_USERNAME)"

# Apply Terraform Infrastructure
terraform-apply:
	@echo "Applying Terraform infrastructure..."
	@cd terraform && terraform apply \
		-var="aws_profile=$(TF_VAR_AWS_PROFILE)" \
		-var="aws_default_region=$(TF_VAR_AWS_DEFAULT_REGION)" \
		-var="environment=$(TF_VAR_ENVIRONMENT)" \
		-var="bucket_name=$(TF_VAR_BUCKET_NAME)" \
		-var="db_username=$(TF_VAR_DB_USERNAME)"

# Capture the RDS endpoint and Secrets ARN from Terraform and store it in ~/.bashrc if it doesn't already exist else update it
capture-tf-output:
	@echo "Capturing Terraform output"
	@cd terraform && \
	RDS_ENDPOINT=$$(terraform output --raw rds_endpoint) && \
	RDS_SECRETS_ARN=$$(terraform output --raw rds_secret_arn) && \
	echo "RDS Endpoint is: $$RDS_ENDPOINT" && \
	echo "SECRETS ARN is: $$RDS_SECRETS_ARN" && \
	echo "export RDS_ENDPOINT=$$RDS_ENDPOINT" >> ~/.bashrc && \
	echo "export RDS_SECRETS_ARN=$$RDS_SECRETS_ARN" >> ~/.bashrc

# Destroy Terraform Infrastructure
terraform-destroy:
	@echo "Destroying Terraform infrastructure..."
	@cd terraform && terraform destroy \
		-var="aws_profile=$(TF_VAR_AWS_PROFILE)" \
		-var="aws_default_region=$(TF_VAR_AWS_DEFAULT_REGION)" \
		-var="environment=$(TF_VAR_ENVIRONMENT)" \
		-var="bucket_name=$(TF_VAR_BUCKET_NAME)" \
		-var="db_username=$(TF_VAR_DB_USERNAME)"

# ------------- Serverless Framework Commands --------------

# Deploy Serverless application
build-layer-pymysql:
	@echo "Building PyMySQL Lambda layer..."
	@./install_dependencies.sh
	@echo "PyMySQL layer built."

sls-deploy:
	@echo "Deploying Serverless application..."
	@cd src && serverless deploy --stage $(ENVIRONMENT) --aws-profile $(AWS_PROFILE)

sls-remove:
	@echo "Removing Serverless application..."
	@cd src && serverless remove --stage $(ENVIRONMENT) --aws-profile $(AWS_PROFILE)

# ------------- Default Setup and Cleanup --------------

# Full setup: configure environment, verify variables, initialize Terraform, plan, apply infrastructure, capture-rds-endpoint, and deploy Serverless
all: env check terraform-init terraform-plan terraform-apply capture-rds-endpoint build-layer-pymysql sls-deploy

# Clean up: destroy the Terraform-managed infrastructure and remove the Serverless application
clean: terraform-destroy serverless-remove

# Prevent make from looking for files with these names
.PHONY: env check terraform-init terraform-plan terraform-apply capture-rds-endpoint terraform-destroy build-layer-pymysql sls-deploy all clean