variable "lambda_runtime" {}

variable "db_host" {}

variable "db_user" {}

variable "db_name" {}

variable "db_password" {}

variable "db_read" {}

variable "subnet_ids" {
  type = "map"
}
variable "env_var" {
  type = "map"
}

variable "security_groups" {
  type = "list"
}

variable "deployment_stage" {}
variable "lambda_zip_file_name" {}
variable "aws_region" {}
variable "rest_api_name" {}
data "aws_caller_identity" "current" {}
