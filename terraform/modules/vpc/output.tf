output "vpc_id" {
    value = "${aws_vpc.main.id}"
}

output "subnets_ids" {
    value = "${join(",", aws_subnet.subnet.*.id)}"
}

output "sg_webapp_instances_id" {
    value = "${aws_security_group.webapp_instances.id}"
}

output "sg_webapp_elb_id" {
    value = "${aws_security_group.webapp_elbs.id}"
}
