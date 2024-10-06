import os
import json
import pymysql
from contextlib import contextmanager

from helpers.boto3_client import boto3_client

class DBConn:

    def __init__(self):
        self.credentials = self.get_credentials()
        pass  # We no longer open the connection here; it will be managed in the context

    def get_credentials(self):
        secrets_client = boto3_client.define_secrets_client()
        response = secrets_client.get_secret_value(SecretId=os.environ.get("RDS_SECRETS_ARN"))['SecretString']
        return json.loads(response)

    @contextmanager
    def get_conn(self):
        """Context manager to open and close a DB connection."""        
        conn = pymysql.connect(
            host=os.environ.get("RDS_ENDPOINT").split(':')[0],
            user=self.credentials['username'],
            password=self.credentials['password'],
            db=self.credentials['db_name'],
            port=3306
        )

        try:
            yield conn  # Connection is open and passed to the caller
        finally:
            conn.close()  # Ensure the connection is closed after the operation
