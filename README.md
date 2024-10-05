# Data Engineering Assessment
Data Engineering Challenge for Company A

## **Phase 1**

Build an Extract, Transform, Load (ETL) pipeline that will take this data and move it into a production-ready database that can be easily queried to answer questions for the business.

---

## **Setting Up Environment Variables**

This project requires specific AWS environment variables to be set before running the ETL pipeline. These environment variables are necessary for authentication with AWS services and ensuring the pipeline runs in the correct environment.

The following variables need to be configured:
- `AWS_PROFILE`: The AWS profile to be used for authentication.
- `AWS_DEFAULT_REGION`: The AWS region where the services will be hosted.
- `ENVIRONMENT`: The environment (e.g., development, staging, production) for which the pipeline is running.

### **Makefile Commands**

1. **`make env`**: 
    - Runs a script to set AWS environment variables (`AWS_PROFILE`, `AWS_DEFAULT_REGION`, `ENVIRONMENT`).

2. **`make check`**: 
    - Verifies that the required environment variables are set using a Python script.

3. **`make` or `make all`**: 
    - Runs both `env` and `check` to configure and verify the environment variables in one step.
