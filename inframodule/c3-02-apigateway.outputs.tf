output "api_gateway_id" {
    description = "API Gateway ID"
    value = aws_apigatewayv2_api.api_gw.id
}

output "api_gateway_execution_arn" {
    description = "API Gateway execution arn"
    value = aws_apigatewayv2_api.api_gw.execution_arn
}

output "base_url" {
  description = "Base URL for API Gateway stage."
  value = aws_apigatewayv2_stage.api_gw_stage.invoke_url
}