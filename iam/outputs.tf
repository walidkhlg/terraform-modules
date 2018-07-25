output "ec2_role" {
  value = "${aws_iam_role.ec2_s3.id}"
}
