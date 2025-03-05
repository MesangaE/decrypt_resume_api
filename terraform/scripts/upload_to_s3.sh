#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <bucket_name> <lambda_s3_key> <lambda_zip_path>"
  exit 1
fi

BUCKET_NAME=$1
LAMBDA_S3_KEY=$2
LAMBDA_ZIP_PATH=$3

# Upload Lambda function to S3
echo "Uploading $LAMBDA_ZIP_PATH to s3://$BUCKET_NAME/$LAMBDA_S3_KEY"
aws s3 cp "$LAMBDA_ZIP_PATH" "s3://$BUCKET_NAME/$LAMBDA_S3_KEY"