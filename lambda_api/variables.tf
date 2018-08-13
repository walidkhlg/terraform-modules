variable "rest_api_id" {}
variable "api_root_resource_id" {}
variable "api_execution_arn" {}

variable "function_name" {}
variable "filename" {}
variable "handler" {}
variable "lambda_runtime" {}
variable "lambda_role" {}

variable "authorization" {
  default = "NONE"
}

variable "env_vars" {
  type = "map"
}

variable "request_models" {
  type    = "map"
  default = {"" = ""}
}

variable "request_parameters" {
  type    = "map"
  default = {"" = ""}
}

variable "validator_name" {
  default = "request_validator"
}

variable "validate_body" {
  default = false
}

variable "validate_request_parameters" {
  default = false
}

variable "http_method" {}
variable "resource_id" {}
