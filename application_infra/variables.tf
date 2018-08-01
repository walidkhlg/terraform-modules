data "aws_subnet_ids" "private" {
  vpc_id = "${var.vpc_id}"

  tags {
    "airbus:network" = "private"
  }
}

variable "tags" {
  type = "list"
}

variable "iam_role" {}
variable "instance_type" {}
variable "vpc_id" {}

variable "launch_ami" {}
variable "asg_max" {}
variable "asg_min" {}
variable "asg_capacity" {}
variable "asg_grace" {}

variable "user_data" {
  default = ""
}
