variable "rest_api_id" {}
variable "api_root_resource_id" {}
variable "api_execution_arn" {}

variable "function_name" {}
variable "lambda_s3_bucket" {}
variable "lambda_zip_file_name" {}
variable "handler" {}
variable "lambda_runtime" {}
variable "lambda_role" {}

variable "env_vars" {
  type = "map"

  default = {
    "Name" = "lambda_func"
  }
}
variable "http_method" {}
