output "dbhost" {
  value = "${aws_rds_cluster.db-cluster.endpoint}"
}

output "dbread" {
  value = "${aws_rds_cluster.db-cluster.reader_endpoint}"
}
