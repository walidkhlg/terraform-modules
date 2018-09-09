data "aws_subnet_ids" "private" {
  vpc_id = "${var.vpc_id}"

  tags {
    "airbus:network" = "private"
  }
}

variable "tags" {
  type = "list"
}
variable "bucket_name" {}
variable "dbhost" {}
variable "db_user" {}
variable "db_password" {}
variable "db_name" {}
variable "dbreadname" {}
variable "cloudfront" {}
variable "elb_port" {}
variable "instance_port" {}
variable "iam_role" {}
variable "instance_type" {}
variable "vpc_id" {}
variable "instance_protocol" {}
variable "elb_protocol" {}
variable "launch_ami" {}
variable "asg_max" {}
variable "asg_min" {}
variable "asg_capacity" {}
variable "asg_grace" {}

variable "user_data" {
  default = "<shell></shell>"
}
