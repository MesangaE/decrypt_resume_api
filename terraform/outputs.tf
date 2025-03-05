output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = module.dynamodb.table_name
}

output "bucket_name" {
  description = "The bucket name"
  value       = module.s3.bucket_name
}

output "aws_region" {
  description = "The AWS region"
  value       = var.region
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda.lambda_function_arn
}

output "resume_id" {
  description = "Resume ID from DynamoDB"
  value       = module.dynamodb.resume_id
}

output "api_gateway_url" {
  description = "URL of the API Gateway"
  value       = module.api_gateway.api_gateway_url
}

output "api_invoke_url" {
  description = "Invoke URL of the API Gateway"
  value       = module.api_gateway.api_invoke_url
}
