resource "aws_dynamodb_table" "user_table" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "email"

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "age"
    type = "N"
  }

  attribute {
    name = "address"
    type = "S"
  }

  attribute {
    name = "phone"
    type = "S"
  }

  attribute {
    name = "image_link"
    type = "S"
  }

  attribute {
    name = "linkedin_link"
    type = "S"
  }

  attribute {
    name = "github_link"
    type = "S"
  }

  tags = {
    Name        = "UserTable"
    Environment = "production"
  }
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table for users."
  value       = aws_dynamodb_table.user_table.arn
}
