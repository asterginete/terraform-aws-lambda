variable "aws_region" {
  description = "The AWS region to deploy resources in."
  default     = "us-west-1"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for users."
  default     = "Users"
  type        = string
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda functions."
  default     = "nodejs14.x"
  type        = string
}

variable "api_name" {
  description = "The name of the API Gateway."
  default     = "UserAPI"
  type        = string
}

variable "ssm_secret_path" {
  description = "The path in AWS SSM to store secrets."
  default     = "/path/to/secret"
  type        = string
}

variable "s3_backend_bucket" {
  description = "The S3 bucket name for storing Terraform state."
  default     = "my-terraform-backend-bucket"
  type        = string
}

variable "dynamodb_lock_table_name" {
  description = "The name of the DynamoDB table for Terraform state locking."
  default     = "terraform-up-and-running-locks"
  type        = string
}
