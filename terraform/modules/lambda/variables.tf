variable "region" {
  description = "AWS region"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "lambda_zip_path" {
  description = "Path to the Lambda function zip file"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Amount of time in seconds your Lambda Function has to run"
  type        = number
  default     = 30
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "json_file_key" {
  description = "The key of the JSON file in the S3 bucket"
  type        = string
}

variable "lambda_s3_key" {
  description = "The S3 key for the Lambda code zip."
  type        = string
}

variable "resume_id" {
  type        = string
  description = "The resume ID"
}

variable "api_gateway_url" {
  description = "The API gateway URL"
  type        = string
}