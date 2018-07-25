output "logs_bucket_name" {
  value = "${aws_s3_bucket.logs_bucket.id}"
}

output "bucket_name" {
  value = "${aws_s3_bucket.app_bucket.id}"
}
