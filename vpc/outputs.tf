output "subnet_ids" {
  value = {
    public1 = "${aws_subnet.public1_subnet.id}"
    public2 = "${aws_subnet.public2_subnet.id}"
    rds1    = "${aws_subnet.rds1_subnet.id}"
    rds2    = "${aws_subnet.rds2_subnet.id}"
  }
}

output "vpc_id" {
  value = "${aws_vpc.pattern1.id}"
}
