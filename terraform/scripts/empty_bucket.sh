#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
BUCKET_NAME="$1"
AWS_REGION="$2"

# Check if the bucket exists
if ! aws s3api head-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION" 2>/dev/null; then
  echo "Bucket $BUCKET_NAME does not exist in region $AWS_REGION."
  exit 0
fi

echo "Deleting all objects and versions from bucket $BUCKET_NAME in region $AWS_REGION"

# Delete all objects
aws s3 rm s3://$BUCKET_NAME --recursive --region $AWS_REGION

# If versioning is enabled, delete all object versions
aws s3api list-object-versions --bucket $BUCKET_NAME --region $AWS_REGION --query "Versions[].[Key,VersionId]" --output text | \
while read -r key version_id; do
  aws s3api delete-object --bucket $BUCKET_NAME --key "$key" --version-id "$version_id" --region $AWS_REGION
done

# If there are delete markers, delete them too
aws s3api list-object-versions --bucket $BUCKET_NAME --region $AWS_REGION --query "DeleteMarkers[].[Key,VersionId]" --output text | \
while read -r key version_id; do
  aws s3api delete-object --bucket $BUCKET_NAME --key "$key" --version-id "$version_id" --region $AWS_REGION
done

echo "Bucket $BUCKET_NAME emptied."
