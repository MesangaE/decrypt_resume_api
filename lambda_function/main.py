import json
import boto3
import os

# Initialize DynamoDB client
dynamodb = boto3.client('dynamodb')

# Environment variables
DYNAMODB_TABLE = os.environ['TABLE_NAME']
RESUME_ID = os.environ.get('RESUME_ID')

def lambda_handler(event, context):
    try:
        # Debugging: log the incoming event
        print("Received event: " + json.dumps(event))

        # Determine the resume_id to use
        if 'queryStringParameters' in event and event['queryStringParameters'] is not None and 'resume_id' in event['queryStringParameters']:
            resume_id = event['queryStringParameters']['resume_id']
        elif RESUME_ID:
            resume_id = RESUME_ID
        else:
            return {
                'statusCode': 400,
                'body': json.dumps({'message': 'Missing query string parameter: resume_id'})
            }

        # Retrieve resume data from DynamoDB
        response = dynamodb.get_item(
            TableName=DYNAMODB_TABLE,
            Key={
                'resume_id': {'S': resume_id}
            }
        )

        # Check if item exists
        if 'Item' not in response:
            return {
                'statusCode': 404,
                'body': json.dumps({'message': 'Resume not found'})
            }

        resume_data = response['Item']
        parsed_resume_data = {k: v['S'] if 'S' in v else v for k, v in resume_data.items()}

        return {
            'statusCode': 200,
            'body': json.dumps(parsed_resume_data)
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'message': str(e)})
        }
