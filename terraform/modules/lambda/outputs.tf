output "lambda_function_name" {
  value = aws_lambda_function.fetch_resume.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.fetch_resume.arn
}
