###############################
#ELastic Classic Load Balancer#
###############################

resource "aws_elb" "elb_virtus" {
  name                      = "aws368-euw2-prod-elb01-test"
  internal                  = false
  security_groups           = ["${aws_security_group.elb-sg.id}"]
  subnets                   = ["${aws_subnet.my_subnet1.id}", "${aws_subnet.my_subnet2.id}"]
  cross_zone_load_balancing = true
  idle_timeout              = 60

  access_logs {
    bucket        = "aws172-euw2-elb-logs-test"
    bucket_prefix = "bar"
    interval      = 60
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.web1.id}", "${aws_instance.web2.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "aws368-euw2-prod-elb01-test"
  }
}