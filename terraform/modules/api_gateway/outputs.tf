output "api_gateway_url" {
  description = "URL of the API Gateway"
  value       = aws_api_gateway_deployment.api_deployment.invoke_url
}

output "api_invoke_url" {
  value = "https://${aws_api_gateway_rest_api.resume_api.id}.execute-api.${var.region}.amazonaws.com/${var.api_gateway_stage_name}/resume/${var.resume_id}"
}