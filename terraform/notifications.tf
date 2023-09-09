# SNS Topic for User Notifications
resource "aws_sns_topic" "user_notifications" {
  name              = "UserNotificationsTopic"
  display_name      = "User Notifications"
  kms_master_key_id = var.kms_key_id  # Optional: If you want to encrypt the messages

  tags = {
    Name        = "UserNotificationsTopic"
    Environment = var.environment
  }
}

# SNS Subscription for Email Notifications
resource "aws_sns_topic_subscription" "email_notifications" {
  topic_arn = aws_sns_topic.user_notifications.arn
  protocol  = "email"
  endpoint  = var.notification_email_endpoint
}

# SNS Subscription for SMS Notifications (Optional)
resource "aws_sns_topic_subscription" "sms_notifications" {
  topic_arn = aws_sns_topic.user_notifications.arn
  protocol  = "sms"
  endpoint  = var.notification_sms_endpoint
}

# IAM Role for Lambda to Publish to SNS
resource "aws_iam_role" "lambda_sns_publish" {
  name = "LambdaSNSTopicPublishRole"

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

resource "aws_iam_role_policy_attachment" "lambda_sns_full_access" {
  role       = aws_iam_role.lambda_sns_publish.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

# Output for the SNS Topic ARN
output "user_notifications_topic_arn" {
  description = "The ARN of the SNS topic for user notifications."
  value       = aws_sns_topic.user_notifications.arn
}
