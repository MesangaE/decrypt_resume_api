variable "region" {
  description = "AWS region"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function"
  type        = string
}

variable "api_gateway_stage_name" {
  description = "Stage name for the API Gateway"
  type        = string
  default     = "dev"
}

variable "resume_id" {
  description = "Resume ID"
  type        = string
}
