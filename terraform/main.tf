provider "aws" {
  region = var.region
}



module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "dynamodb" {
  source                = "./modules/dynamodb"
  table_name            = var.table_name
  read_capacity         = var.read_capacity
  write_capacity        = var.write_capacity
  hash_key              = var.hash_key
  attribute_definitions = var.attribute_definitions
  tags                  = var.tags
  resume_file           = var.resume_file
}

module "lambda" {
  source               = "./modules/lambda"
  region               = var.region
  table_name           = var.table_name
  lambda_zip_path      = var.lambda_zip_path
  lambda_function_name = var.lambda_function_name
  bucket_name          = module.s3.bucket_name
  json_file_key        = var.json_file_key
  lambda_s3_key        = var.lambda_s3_key
  lambda_memory_size   = var.lambda_memory_size
  lambda_timeout       = var.lambda_timeout
  resume_id            = module.dynamodb.resume_id
  api_gateway_url      = module.api_gateway.api_gateway_url
}

module "api_gateway" {
  source              = "./modules/api_gateway"
  region              = var.region
  lambda_function_arn = module.lambda.lambda_function_arn
  resume_id           = module.dynamodb.resume_id
}

resource "null_resource" "upload_lambda_package" {
  provisioner "local-exec" {
    command = <<EOT
      ./scripts/upload_to_s3.sh ${var.bucket_name} ${var.lambda_s3_key} ${var.lambda_zip_path}
      echo "Lambda function uploaded"
    EOT
  }
  depends_on = [module.s3]
}
