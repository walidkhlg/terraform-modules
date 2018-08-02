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

variable "http_method" {}
variable "resource_id" {}
