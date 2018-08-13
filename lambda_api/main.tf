resource "aws_lambda_function" "func" {
  function_name    = "${var.function_name}"
  handler          = "${var.handler}"
  runtime          = "${var.lambda_runtime}"
  role             = "${var.lambda_role}"
  filename         = "${var.filename}"
  source_code_hash = "${base64sha256(file("${var.filename}"))}"

  environment {
    variables = "${var.env_vars}"
  }
}

resource "aws_api_gateway_method" "gw_method" {
  rest_api_id        = "${var.rest_api_id}"
  resource_id        = "${var.resource_id}"
  http_method        = "${var.http_method}"
  authorization      = "${var.authorization}"
  request_models     = "${var.request_models}"
  request_parameters = "${var.request_parameters}"
}

resource "aws_api_gateway_integration" "intergration" {
  rest_api_id             = "${var.rest_api_id}"
  resource_id             = "${aws_api_gateway_method.gw_method.resource_id}"
  http_method             = "${aws_api_gateway_method.gw_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.func.invoke_arn}"
}

resource "aws_api_gateway_method_response" "response_method" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_integration.intergration.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "response_method_integration" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method_response.response_method.http_method}"
  status_code = "${aws_api_gateway_method_response.response_method.status_code}"
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.func.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_execution_arn}/*/*/*"
}

resource "aws_api_gateway_request_validator" "validator" {
  name                        = "${var.validator_name}"
  rest_api_id                 = "${var.rest_api_id}"
  validate_request_body       = "${var.validate_body}"
  validate_request_parameters = "${var.validate_request_parameters}"
}
