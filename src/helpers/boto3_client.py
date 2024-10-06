import os
import boto3

class Boto3Client:

    def __init__(self):        
        self.base_session = self._base_session()

    def _base_session(self):
        
        if os.environ.get("AWS_PROFILE") is None:
            return boto3.Session(region_name="us-east-1")
        
        else:
            return boto3.Session(
                    profile_name=os.environ.get("AWS_PROFILE"),
                    region_name="us-east-1")
    
    def define_secrets_client(self):
        return self.base_session.client(service_name="secretsmanager")

boto3_client = Boto3Client()