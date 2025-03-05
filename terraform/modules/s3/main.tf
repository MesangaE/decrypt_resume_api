resource "aws_s3_bucket" "resume_bucket" {
  bucket = var.bucket_name

}

resource "aws_s3_bucket_versioning" "resume_bucket" {
  bucket = aws_s3_bucket.resume_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
