output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.db.name
}

output "resume_id" {
  value = data.external.upload_resume.result["resume_id"]
}