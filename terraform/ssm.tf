resource "aws_ssm_parameter" "some_secret" {
  name  = var.ssm_secret_path
  type  = "SecureString"
  value = "your_secret_value"
}

output "secret_value" {
  description = "The value of the secret stored in AWS SSM."
  value       = aws_ssm_parameter.some_secret.value
  sensitive   = true
}
