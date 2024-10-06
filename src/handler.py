import json
import urllib.parse

def hello(event, context):
    
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

    print(f"Bucket: {bucket}")
    print(f"Key: {key}")


    body = {
        "message": "Go Serverless v4.0! Your function executed successfully!"
    }

    return {"statusCode": 200, "body": json.dumps(body)}
