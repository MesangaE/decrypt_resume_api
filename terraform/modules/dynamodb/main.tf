resource "aws_dynamodb_table" "db" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key

  attribute {
    name = "resume_id"
    type = "S"
  }

  tags = var.tags

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

data "external" "upload_resume" {
  depends_on = [aws_dynamodb_table.db]

  program = ["python3", "scripts/upload_resume.py"]

  query = {
    table_name  = var.table_name
    resume_file = var.resume_file
  }
}