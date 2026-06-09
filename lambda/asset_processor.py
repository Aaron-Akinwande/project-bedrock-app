import json

def handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        filename = record['s3']['object']['key']
        print(f"Image received: {filename}")
        print(f"Bucket: {bucket}")
    return {
        'statusCode': 200,
        'body': json.dumps('Success')
    }
