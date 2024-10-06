from decouple import config, UndefinedValueError

def check_environment_variables():
    """
    Check if the necessary environment variables are set using python-decouple.
    """
    try:
    
        # Check standard environment variables
        aws_profile = config('AWS_PROFILE')
        aws_default_region = config('AWS_DEFAULT_REGION')
        environment = config('ENVIRONMENT')
        bucket_name = config('BUCKET_NAME')
        db_USERNAME = config('DB_USERNAME')

        # Check Terraform-specific variables (optional, if required for Terraform)
        tf_aws_profile = config('TF_VAR_AWS_PROFILE')
        tf_aws_default_region = config('TF_VAR_AWS_DEFAULT_REGION')
        tf_environment = config('TF_VAR_ENVIRONMENT')
        tf_bucket_name = config('TF_VAR_BUCKET_NAME')
        tf_db_USERNAME = config('TF_VAR_DB_USERNAME')
        
    except UndefinedValueError as e:
        raise KeyError(f"Missing environment variable: {e}")

    print(f"Environment variables loaded successfully:\n"
          f"AWS_PROFILE: {aws_profile}\n"
          f"AWS_DEFAULT_REGION: {aws_default_region}\n"
          f"ENVIRONMENT: {environment}\n"
          f"BUCKET_NAME: {bucket_name}\n"
          f"DB_USERNAME: {db_USERNAME}\n"
          f"TF_VAR_AWS_PROFILE: {tf_aws_profile}\n"
          f"TF_VAR_AWS_DEFAULT_REGION: {tf_aws_default_region}\n"
          f"TF_VAR_ENVIRONMENT: {tf_environment}\n"
          f"TF_VAR_BUCKET_NAME: {tf_bucket_name}\n"
          f"TF_VAR_DB_USERNAME: {tf_db_USERNAME}\n"
)

# Example usage:
if __name__ == '__main__':
    check_environment_variables()  # Now check if they are set