output "private_sg_id" {
  value = "${aws_security_group.sg-private.id}"
}

output "elb_address" {
  value = "${aws_elb.web-elb.dns_name}"
}
