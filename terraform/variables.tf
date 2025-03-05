variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "resume"
}

variable "read_capacity" {
  description = "Read capacity units"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Write capacity units"
  type        = number
  default     = 5
}

variable "hash_key" {
  description = "Hash key attribute name"
  type        = string
  default     = "resume_id"
}

variable "attribute_definitions" {
  description = "List of attribute definitions"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    { name = "resume_id", type = "S" }
  ]
}

variable "tags" {
  description = "Tags for the DynamoDB table"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "ResumeDataStore"
  }
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "json_file_key" {
  description = "The key of the JSON file in the S3 bucket"
  type        = string
}

variable "api_gateway_stage_name" {
  description = "Stage name for the API Gateway"
  type        = string
  default     = "dev"
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

variable "lambda_zip_path" {
  description = "Path to the Lambda function zip file"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_s3_key" {
  description = "The S3 key for the Lambda code zip."
  type        = string
}

variable "resume_file" {
  description = "Path to resume file locally"
  type        = string
}
