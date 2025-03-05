
region         = "eu-north-1"
table_name     = "mesanga-resume-table"
read_capacity  = 10
write_capacity = 10
hash_key       = "resume_id"
attribute_definitions = [
  { name = "resume_id", type = "S" },
]
tags = {
  Environment = "Demonstration"
  Project     = "resume conversion"
}
lambda_zip_path        = "../terraform/lambda_function.zip"
lambda_function_name   = "mesanga-resume-function"
lambda_memory_size     = 256
lambda_timeout         = 60
api_gateway_stage_name = "mesanga-api"
bucket_name            = "mesanga-resume"
json_file_key          = "resume.json"
lambda_s3_key          = "lambda/lambda_function.zip"
resume_file            = "./resume.json"
