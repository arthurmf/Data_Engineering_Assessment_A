import json
import urllib.parse

from aws_lambda_powertools import Logger
from aws_lambda_powertools.utilities.typing import LambdaContext

from helpers.aws_wrangler import AWSWrangler
from helpers.db_conn import DBConn
from helpers.transform import transform

logger = Logger()
logger._logger.propagate = False

db = DBConn()
wr = AWSWrangler(logger, db)

@logger.inject_lambda_context()
def etl(event: dict, context: LambdaContext) -> str:
    
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    logger.append_keys(bucket=bucket, key=key)

    df = wr.read_csv(f"s3://{bucket}/{key}") # Extract
    df = transform(df) # Transform
    wr.insert_db(df, "credit_card_data") # Load

    return_body = {
        "message": "Go Serverless v4.0! Your function executed successfully!"
    }

    logger.info("Function executed successfully!")
    return {"statusCode": 200, "body": json.dumps(return_body)}
