import os

def check_environment_variables():
    for env_var in ['AWS_PROFILE','AWS_DEFAULT_REGION', 'ENVIRONMENT']:
        try:
            env_var_value = os.environ[env_var]
        except KeyError:
            raise KeyError(f'Environment variable {env_var} not found. Please set it up before starting.')