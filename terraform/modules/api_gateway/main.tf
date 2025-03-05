provider "aws" {
  region = var.region
}

resource "aws_api_gateway_rest_api" "resume_api" {
  name        = "resume_api"
  description = "API Gateway for fetching resume data"
}

resource "aws_api_gateway_resource" "resume" {
  rest_api_id = aws_api_gateway_rest_api.resume_api.id
  parent_id   = aws_api_gateway_rest_api.resume_api.root_resource_id
  path_part   = "resume"
}

resource "aws_api_gateway_resource" "resume_with_id" {
  rest_api_id = aws_api_gateway_rest_api.resume_api.id
  parent_id   = aws_api_gateway_resource.resume.id
  path_part   = var.resume_id
}

resource "aws_api_gateway_method" "get_resume" {
  rest_api_id   = aws_api_gateway_rest_api.resume_api.id
  resource_id   = aws_api_gateway_resource.resume_with_id.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.querystring.resume_id" = true
  }
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.resume_api.id
  resource_id = aws_api_gateway_method.get_resume.resource_id
  http_method = aws_api_gateway_method.get_resume.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_function_arn}/invocations"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.resume_api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.resume_api.id
  stage_name  = var.api_gateway_stage_name
}


