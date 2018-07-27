data "aws_subnet_ids" "local" {
  vpc_id = "${var.vpc_id}"

  tags {
    "airbus:network" = "local"
  }
}
variable "db_instance_tags" {
  type = "map"
}

variable "vpc_id" {}

variable "security_group_ids" {
  type = "list"
}

variable "db_engine" {
  default = "aurora-mysql"
}

variable "kms_key_id" {}

variable "db_name" {}
variable "db_user" {}
variable "db_instance_class" {}
variable "db_password" {}
