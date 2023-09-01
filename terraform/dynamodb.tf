# Users Table
resource "aws_dynamodb_table" "users" {
  name           = "UsersTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "email"

  attribute {
    name = "email"
    type = "S"
  }

  tags = {
    Name        = "UsersTable"
    Environment = var.environment
  }
}

# Chat Messages Table
resource "aws_dynamodb_table" "chat_messages" {
  name           = "ChatMessagesTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "chat_id"
  range_key      = "timestamp"

  attribute {
    name = "chat_id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  tags = {
    Name        = "ChatMessagesTable"
    Environment = var.environment
  }
}

# Feedback Table
resource "aws_dynamodb_table" "feedback" {
  name           = "FeedbackTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "feedback_id"

  attribute {
    name = "feedback_id"
    type = "S"
  }

  tags = {
    Name        = "FeedbackTable"
    Environment = var.environment
  }
}

# Notifications Table
resource "aws_dynamodb_table" "notifications" {
  name           = "NotificationsTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "notification_id"

  attribute {
    name = "notification_id"
    type = "S"
  }

  tags = {
    Name        = "NotificationsTable"
    Environment = var.environment
  }
}

# User Sessions Table
resource "aws_dynamodb_table" "user_sessions" {
  name           = "UserSessionsTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "session_id"

  attribute {
    name = "session_id"
    type = "S"
  }

  tags = {
    Name        = "UserSessionsTable"
    Environment = var.environment
  }
}

# Outputs for each table's ARN
output "users_table_arn" {
  description = "The ARN of the DynamoDB table for users."
  value       = aws_dynamodb_table.users.arn
}

output "chat_messages_table_arn" {
  description = "The ARN of the DynamoDB table for chat messages."
  value       = aws_dynamodb_table.chat_messages.arn
}

output "feedback_table_arn" {
  description = "The ARN of the DynamoDB table for feedback."
  value       = aws_dynamodb_table.feedback.arn
}

output "notifications_table_arn" {
  description = "The ARN of the DynamoDB table for notifications."
  value       = aws_dynamodb_table.notifications.arn
}

output "user_sessions_table_arn" {
  description = "The ARN of the DynamoDB table for user sessions."
  value       = aws_dynamodb_table.user_sessions.arn
}
