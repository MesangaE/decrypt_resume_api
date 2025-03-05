import sys
import json
import boto3
import uuid
from botocore.exceptions import ClientError

def convert_to_dynamodb_item(data):
    item = {}
    for key, value in data.items():
        if isinstance(value, str):
            item[key] = {'S': value}
        elif isinstance(value, int) or isinstance(value, float):
            item[key] = {'N': str(value)}
        elif isinstance(value, bool):
            item[key] = {'BOOL': value}
        elif isinstance(value, list):
            item[key] = {'L': [convert_to_dynamodb_item({"item": v})['item'] for v in value]}
        elif isinstance(value, dict):
            item[key] = {'M': convert_to_dynamodb_item(value)}
        else:
            item[key] = {'S': str(value)}
    return item

def upload_resume(table_name, resume_file):
    dynamodb = boto3.client('dynamodb')

    try:
        with open(resume_file, 'r') as file:
            resume_data = json.load(file)
    except json.JSONDecodeError as e:
        return {
            'status': 'error',
            'message': f'Invalid JSON format: {e}'
        }
    except Exception as e:
        return {
            'status': 'error',
            'message': f'Error reading file: {e}'
        }

    resume_id = resume_data.get("resume_id")
    if not resume_id:
        resume_id = str(uuid.uuid4())
        resume_data["resume_id"] = resume_id

    item = convert_to_dynamodb_item(resume_data)
    item['resume_id'] = {'S': resume_id}

    try:
        response = dynamodb.put_item(
            TableName=table_name,
            Item=item
        )
        return {
            'status': 'success',
            'resume_id': resume_id
        }
    except ClientError as e:
        return {
            'status': 'error',
            'message': e.response['Error']['Message']
        }

if __name__ == '__main__':
    input_data = json.load(sys.stdin)
    table_name = input_data.get('table_name')
    resume_file = input_data.get('resume_file')

    if not table_name or not resume_file:
        print(json.dumps({
            'status': 'error',
            'message': 'Missing required parameters'
        }))
        sys.exit(1)

    result = upload_resume(table_name, resume_file)
    print(json.dumps(result))
