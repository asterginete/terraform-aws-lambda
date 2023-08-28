# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "LambdaDynamoDBRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_full_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Functions

resource "aws_lambda_function" "create_user" {
  filename      = "lambdas/create_user.zip"
  function_name = "createUser"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = var.lambda_runtime

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.user_table.name
    }
  }
}

resource "aws_lambda_function" "read_user" {
  filename      = "lambdas/read_user.zip"
  function_name = "readUser"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = var.lambda_runtime

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.user_table.name
    }
  }
}

resource "aws_lambda_function" "update_user" {
  filename      = "lambdas/update_user.zip"
  function_name = "updateUser"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = var.lambda_runtime

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.user_table.name
    }
  }
}

resource "aws_lambda_function" "delete_user" {
  filename      = "lambdas/delete_user.zip"
  function_name = "deleteUser"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = var.lambda_runtime

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.user_table.name
    }
  }
}

# Outputs for Lambda ARNs

output "create_user_lambda_arn" {
  description = "The ARN of the Lambda function for creating users."
  value       = aws_lambda_function.create_user.arn
}

output "read_user_lambda_arn" {
  description = "The ARN of the Lambda function for reading user data."
  value       = aws_lambda_function.read_user.arn
}

output "update_user_lambda_arn" {
  description = "The ARN of the Lambda function for updating user data."
  value       = aws_lambda_function.update_user.arn
}

output "delete_user_lambda_arn" {
  description = "The ARN of the Lambda function for deleting users."
  value       = aws_lambda_function.delete_user.arn
}
