variable "identifier" {}
variable "db_engine" {}
variable "multi_az" {}
variable "kms_key" {}
variable "backup_retention_period" {}
variable "db_user" {}
variable "db_password" {}

variable "db_port" {
  default = "1433"
}

variable "allocated_storage" {}
variable "db_instance_class" {}

variable "tags" {
  type = "map"
}

variable "vpc_id" {}
