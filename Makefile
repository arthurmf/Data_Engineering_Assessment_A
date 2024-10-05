# Define bash as the shell for Makefile
SHELL := /bin/bash

# Define variables
PYTHON := python3

# ------------- Environment Setup --------------

# Target to source the set_aws_env.sh script and set environment variables in the current session
env:
	@echo "Configuring environment variables..."
	@. ./set_aws_env.sh  # Source the script directly

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
	@cd terraform && TF_VAR_aws_profile=$(AWS_PROFILE) TF_VAR_aws_region=$(AWS_DEFAULT_REGION) TF_VAR_environment=$(ENVIRONMENT) terraform plan

# Apply Terraform Infrastructure
terraform-apply:
	@echo "Applying Terraform infrastructure..."
	@cd terraform && TF_VAR_aws_profile=$(AWS_PROFILE) TF_VAR_aws_region=$(AWS_DEFAULT_REGION) TF_VAR_environment=$(ENVIRONMENT) terraform apply

# Destroy Terraform Infrastructure
terraform-destroy:
	@echo "Destroying Terraform infrastructure..."
	@cd terraform && terraform destroy

# ------------- Default Setup and Cleanup --------------

# Full setup: configure environment, verify variables, initialize Terraform, plan and apply infrastructure
all: env check terraform-init terraform-plan terraform-apply

# Clean up: destroy the Terraform-managed infrastructure
clean: terraform-destroy

# Prevent make from looking for files with these names
.PHONY: env check terraform-init terraform-plan terraform-apply terraform-destroy all clean