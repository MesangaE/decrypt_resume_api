terraform {
  backend "s3" {
    bucket         = "mesanga_resume"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "resume-state"
    encrypt        = true
  }
}
