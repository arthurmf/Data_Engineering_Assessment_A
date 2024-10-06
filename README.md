# Data Engineering Assessment
Data Engineering Challenge for Company A

## **Phase 1**

Build an Extract, Transform, Load (ETL) pipeline that will take this data and move it into a production-ready database that can be easily queried to answer questions for the business.

Additionally, the infrastructure required for hosting and managing the ETL pipeline, including networking and storage, will be provisioned using Terraform.

---

## **Requirements**

Before setting up the environment, ensure that you have the following tools installed and configured:

1. **AWS CLI**  
   Install the AWS Command Line Interface (AWS CLI) by following the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).  
   After installation, configure the AWS CLI with your credentials:
   ```bash
   aws configure
   ```

2. **Terraform**  
   Terraform is used to provision the AWS infrastructure required for the project. You can install Terraform by following the instructions [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). After installation, verify that Terraform is installed correctly by running:
   ```bash
   terraform --version
   ```

3. **Python**  
   Ensure you have Python 3.x installed to execute validation scripts for environment variables. You can download and install Python [here](https://www.python.org/downloads/).

---

## **Setting Up Environment Variables**

This project requires specific AWS environment variables to be set before running the ETL pipeline and the infrastructure provisioning process. These environment variables are necessary for authentication with AWS services and ensuring the pipeline and infrastructure run in the correct environment.

The following variables need to be configured:

- `AWS_PROFILE`: The AWS profile to be used for authentication.
- `AWS_DEFAULT_REGION`: The AWS region where the services will be hosted.
- `ENVIRONMENT`: The environment (e.g., development, staging, production) for which the pipeline and infrastructure are being deployed.

### **Makefile Commands**

The `Makefile` includes commands to automate setting up the environment and provisioning the infrastructure using Terraform.

1. **`make env`**:  
   Runs a script to set AWS environment variables (`AWS_PROFILE`, `AWS_DEFAULT_REGION`, `ENVIRONMENT`) and persists them to `~/.bashrc`.

2. **`make check`**:  
   Verifies that the required environment variables are set using a Python script.

3. **`make terraform-init`**:  
   Initializes Terraform, downloading providers and setting up your environment for infrastructure provisioning.

4. **`make terraform-plan`**:  
   Runs Terraform's `plan` command to preview the infrastructure that will be created.

5. **`make terraform-apply`**:  
   Applies the Terraform plan to create the infrastructure automatically.

6. **`make terraform-destroy`**:  
   Destroys the Terraform-managed infrastructure automatically.

7. **`make all`**:  
   Runs the entire setup process in one step. It configures environment variables, verifies them, initializes Terraform, plans the infrastructure, and applies it.

8. **`make clean`**:  
   Destroys all infrastructure created by Terraform.

---

## **Important: Environment Variable Persistence**

After running **`make env`** or **`make all`**, the environment variables are saved to `~/.bashrc` to persist across terminal sessions. However, these variables might not be immediately available in your current session. 

### To ensure the environment variables are loaded:
- **Option 1**: Restart your terminal or prompt to apply the changes.
- **Option 2**: Manually source the updated `~/.bashrc` file by running:
  ```bash
  source ~/.bashrc
  ```

Failure to do this may result in the environment variables not being available in the current terminal session.

---

## **Infrastructure Setup Using Terraform**

The infrastructure for this project is managed using **Terraform**. This setup includes the creation of an Amazon S3 bucket for storage, a VPC, subnets, and other necessary networking components. The infrastructure code is located in the `terraform/` directory.

### **Terraform Configuration Files**

The key configuration files for Terraform are:

1. **`resource.tf`**  
   This file defines the S3 bucket and related configurations such as server-side encryption and object storage.

2. **`networks.tf`**  
   This file contains the configuration for the Virtual Private Cloud (VPC), public subnets, Internet Gateway (IGW), and route tables.

3. **`local.tf`**  
   This file defines local variables that are used across the Terraform configuration files, including common tags, network CIDR blocks, and bucket names.

## **Serverless Framework Deployment**

This project includes a Serverless Framework configuration to deploy an ETL Lambda function. After setting up the environment variables and provisioning the AWS infrastructure with Terraform, you can deploy the Serverless application.

Ensure the environment variables are correctly set by running `make env`.

### **To deploy the Serverless application:**

1. Install the Serverless Framework:
   ```bash
   npm install -g serverless
   ```

2. Navigate to the `src/` directory:
   ```bash
   cd src
   ```

3. Deploy the Serverless application to AWS:
   ```bash
   serverless deploy --stage dev
   ```

Alternatively, you can use the following `Makefile` command to handle deployment after Terraform has completed:
```bash
make sls-deploy
```

This command will automatically deploy the Serverless Framework configuration, making the ETL Lambda function available.