variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "read_capacity" {
  description = "Read capacity units"
  type        = number
}

variable "write_capacity" {
  description = "Write capacity units"
  type        = number
}

variable "hash_key" {
  description = "Hash key attribute name"
  type        = string
}

variable "attribute_definitions" {
  description = "LIst of attribute definitions"
  type = list(object({
    name = string
    type = string
  }))
}

variable "tags" {
  description = "Tags for the DynamoDB table"
  type        = map(string)
}
variable "resume_file" {
  description = "Path to resume file locally"
  type        = string
}