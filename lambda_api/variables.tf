variable "rest_api_id" {}
variable "api_root_resource_id" {}
variable "api_execution_arn" {}

variable "function_name" {}
variable "lambda_s3_bucket" {}
variable "lambda_zip_file_name" {}
variable "handler" {}
variable "lambda_runtime" {}
variable "lambda_role" {}
variable "resource_path" {}

variable "authorization" {
  default = "NONE"
}

variable "http_method" {}
variable "resource_id" {}
