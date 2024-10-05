# Define variables
PYTHON := python3

# Target to run the set_aws_env.sh script
env:
	@echo "Configuring environment variables..."
	@bash set_aws_env.sh

# Target to verify if environment variables are set
check:
	@echo "Verifying environment variables..."
	@$(PYTHON) -c "from utils import check_environment_variables; check_environment_variables()"
	@echo "All environment variables are set!"

# Default target (runs both tasks)
all: env check

# Prevent make from looking for files with these names
.PHONY: env check all