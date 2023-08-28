resource "aws_apigatewayv2_api" "user_api" {
  name          = var.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_route" "create_user_route" {
  api_id    = aws_apigatewayv2_api.user_api.id
  route_key = "POST /users"
  target    = "integrations/${aws_apigatewayv2_integration.create_user_integration.id}"
}

resource "aws_apigatewayv2_integration" "create_user_integration" {
  api_id           = aws_apigatewayv2_api.user_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.create_user.invoke_arn
}

# ... Repeat for Read, Update, Delete

output "api_endpoint_url" {
  description = "The endpoint URL of the API Gateway."
  value       = aws_apigatewayv2_api.user_api.api_endpoint
}
