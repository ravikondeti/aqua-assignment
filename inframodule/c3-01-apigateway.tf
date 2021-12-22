# API Gateway resource
resource "aws_apigatewayv2_api" "api_gw" {
  name          = var.api_gateway_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "api_gw_stage" {
  api_id = aws_apigatewayv2_api.api_gw.id
  name        = var.api_gateway_stage_name
  auto_deploy = true
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw_loggroup.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

#Log group resouce for API GW
resource "aws_cloudwatch_log_group" "api_gw_loggroup" {
  name = "/aws/api_gw_log/${aws_apigatewayv2_api.api_gw.name}"
  retention_in_days = 30
}





