output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table for users."
  value       = module.dynamodb.dynamodb_table_arn
}

output "api_endpoint" {
  description = "The endpoint URL of the API Gateway."
  value       = module.apigateway.api_endpoint_url
}

output "create_user_lambda_arn" {
  description = "The ARN of the Lambda function for creating users."
  value       = module.lambda.create_user_lambda_arn
}

output "read_user_lambda_arn" {
  description = "The ARN of the Lambda function for reading user data."
  value       = module.lambda.read_user_lambda_arn
}

output "update_user_lambda_arn" {
  description = "The ARN of the Lambda function for updating user data."
  value       = module.lambda.update_user_lambda_arn
}

output "delete_user_lambda_arn" {
  description = "The ARN of the Lambda function for deleting users."
  value       = module.lambda.delete_user_lambda_arn
}

output "ssm_secret_value" {
  description = "The value of the secret stored in AWS SSM."
  value       = module.ssm.secret_value
  sensitive   = true
}
