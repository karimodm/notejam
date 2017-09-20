output "elb_dns_name" {
    value = "${aws_elb.main.dns_name}"
}

output "elb_name" {
    value = "${aws_elb.main.name}"
}
