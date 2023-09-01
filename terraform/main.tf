provider "aws" {
  region = var.aws_region
}

# DynamoDB for Users, Chats, Feedback, Notifications, and Sessions
module "dynamodb" {
  source = "./dynamodb"
}

# Lambda Functions for CRUD operations, Authentication, Chat, Feedback, and Notifications
module "lambda" {
  source = "./lambda"
}

# API Gateway for routing requests to Lambda functions
module "apigateway" {
  source = "./apigateway"
}

# IAM roles and permissions for Lambda and other services
module "iam" {
  source = "./iam"
}

# SSM for storing secrets
module "ssm" {
  source = "./ssm"
}

# S3 for storing user images and other static assets
module "s3" {
  source = "./s3"
}

# Optional: SNS for notifications
module "sns" {
  source = "./sns"
}

# Optional: Elasticsearch for advanced search capabilities
module "elasticsearch" {
  source = "./elasticsearch"
}

# Optional: Redis or Memcached for caching
module "cache" {
  source = "./cache"
}

# Outputs to retrieve important information after resources have been created or updated
output "api_endpoint" {
  description = "The endpoint URL of the API Gateway."
  value       = module.apigateway.api_endpoint_url
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table for users."
  value       = module.dynamodb.dynamodb_table_arn
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket for user images."
  value       = module.s3.bucket_name
}

# ... Additional outputs for other resources as needed
