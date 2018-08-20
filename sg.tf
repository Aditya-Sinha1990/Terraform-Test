########################
#Virtus Security Groups#
########################

###################
#MIT Management SG#
###################

resource "aws_security_group" "mit-sg" {
  name        = "aws368-euw2-prod-mit-sg-test"
  description = "Allow all outbound traffic"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "aws368-euw2-prod-mit-sg-test"
  }
}

###############
#Web Server SG#
###############

resource "aws_security_group" "web-sg" {
  name        = "aws368-euw2-prod-web-sg-test"
  description = "Allow all outbound traffic"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "aws368-euw2-prod-web-sg-test"
  }
}

########
#ELB SG#
########

resource "aws_security_group" "elb-sg" {
  name        = "aws368-euw2-prod-elb-sg-test"
  description = "Allow all outbound traffic"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "aws368-euw2-prod-elb-sg-test"
  }
}

###########
#RDS DB SG#
###########

resource "aws_security_group" "db-sg" {
  name        = "aws368-euw2-prod-db-sg-test"
  description = "Allow all outbound traffic"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "aws368-euw2-prod-db-sg-test"
  }
}

#############################
#Security Group Rules MIT SG#
#############################

resource "aws_security_group_rule" "mit_ssh" {
  description       = "SSH Connection from MIT Bastion"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0",.......]
  security_group_id = "${aws_security_group.mit-sg.id}"
}

resource "aws_security_group_rule" "nim_soft" {
  description       = "Nimsoft Tunneling "
  type              = "ingress"
  from_port         = 48000
  to_port           = 48030
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", .......]
  security_group_id = "${aws_security_group.mit-sg.id}"
}

resource "aws_security_group_rule" "trend_Micro" {
  description       = "Trend Micro Tunneling "
  type              = "ingress"
  from_port         = 4118
  to_port           = 4118
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", .......]
  security_group_id = "${aws_security_group.mit-sg.id}"
}

resource "aws_security_group_rule" "HTTP_access" {
  description       = "HTTP Access Tunneling "
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", .......]
  security_group_id = "${aws_security_group.mit-sg.id}"
}

resource "aws_security_group_rule" "HTTPS_access" {
  description       = "HTTPS Access Tunneling "
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", ...........]
  security_group_id = "${aws_security_group.mit-sg.id}"
}

#Protocol Number of TCP is 6

resource "aws_security_group_rule" "mit_icmp_echo_request" {
  type              = "ingress"
  from_port         = 8
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mit-sg.id}"
}

/* The Protocol Number
of ICMP is 1 and port number is -1*/

#############################
#Security Group Rules web SG#
#############################

resource "aws_security_group_rule" "between_nodes" {
  description       = "Communication between the nodes"
  type              = "ingress"
  from_port         = 0
  to_port           = 65565
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.web-sg.id}"
}

resource "aws_security_group_rule" "nim_soft_web" {
  description       = "Nimsoft Tunneling "
  type              = "ingress"
  from_port         = 48000
  to_port           = 48030
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", ...........]
  security_group_id = "${aws_security_group.web-sg.id}"
}

resource "aws_security_group_rule" "ssh_access_web" {
  description              = "ssh Access Tunneling "
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mit-sg.id}"
  security_group_id        = "${aws_security_group.web-sg.id}"
}

resource "aws_security_group_rule" "http_access_web" {
  description              = "http access Tunneling "
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elb-sg.id}"
  security_group_id        = "${aws_security_group.web-sg.id}"
}

resource "aws_security_group_rule" "https_access_web" {
  description              = "https access Tunneling "
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elb-sg.id}"
  security_group_id        = "${aws_security_group.web-sg.id}"
}

#############################
#Security Group Rules elb SG#
#############################

resource "aws_security_group_rule" "http_access_elb" {
  description       = "http access Tunneling "
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-sg.id}"
}

resource "aws_security_group_rule" "https_access_elb" {
  description       = "https access Tunneling "
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-sg.id}"
}

resource "aws_security_group_rule" "mit_icmp_echo_request_elb" {
  type              = "ingress"
  from_port         = 8
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-sg.id}"
}

#############################
#Security Group Rules db SG#
#############################
resource "aws_security_group_rule" "db_request" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.web-sg.id}"
  security_group_id        = "${aws_security_group.elb-sg.id}"
}