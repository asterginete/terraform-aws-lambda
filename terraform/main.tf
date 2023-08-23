provider "aws" {
  region  = "us-west-1" # Change this to your desired region
  version = "~> 3.0"   # Specify the version of AWS provider you want to use
}

# Fetch the current account ID and region
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# S3 Backend for storing Terraform state (Optional but recommended for real projects)
terraform {
  backend "s3" {
    bucket = "my-terraform-backend-bucket"
    key    = "path/to/my/key"
    region = "us-west-1"
  }
}

# DynamoDB table for Terraform state locking (Optional but recommended for real projects)
resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-up-and-running-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# Include other Terraform configuration files
module "dynamodb" {
  source = "./dynamodb.tf"
}

module "lambda" {
  source = "./lambda.tf"
}

module "apigateway" {
  source = "./apigateway.tf"
}

module "iam" {
  source = "./iam.tf"
}

module "ssm" {
  source = "./ssm.tf"
}
