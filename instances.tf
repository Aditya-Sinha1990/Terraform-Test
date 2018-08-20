#######################
#Web CentOS Instances #
#######################

resource "aws_instance" "web1" {
  ami                     = "ami-39f8215b"
  instance_type           = "t2.micro"
  subnet_id               = "${aws_subnet.my_subnet1.id}"
  key_name                = "aws368"
  source_dest_check       = "true"
  disable_api_termination = "false"
  monitoring              = "false"
  vpc_security_group_ids  = ["${aws_security_group.web-sg.id}", "${aws_security_group.mit-sg.id}"]

  root_block_device = {
    volume_size           = "30"
    volume_type           = "gp2"
    delete_on_termination = "true"
  }

  ebs_block_device = {
    volume_size           = "30"
    volume_type           = "gp2"
    delete_on_termination = "true"
    device_name           = "/dev/sdg"
  }

  tags {
    Name = "aws368-euw2-prod-web01"
    Role = "Prod Web 1"
  }

  volume_tags {
    Name          = "aws368-prod-web01:/dev/sda1"
    "qb:Schedule" = "{ \"SnapshotsOn\" : \"true\", \"SnapshotTime\" : \"9\", \"CopyPolicy\" : \"none\", \"DaysToKeep\" : \"30\" }"
  }

  lifecycle {
    ignore_changes = ["ami", "volume_tags"]
  }
}

resource "aws_instance" "web2" {
  ami                     = "ami-39f8215b"
  instance_type           = "t2.micro"
  subnet_id               = "${aws_subnet.my_subnet2.id}"
  key_name                = "aws368"
  source_dest_check       = "true"
  disable_api_termination = "false"
  monitoring              = "false"
  vpc_security_group_ids  = ["${aws_security_group.web-sg.id}", "${aws_security_group.mit-sg.id}"]

  root_block_device = {
    volume_size           = "30"
    volume_type           = "gp2"
    delete_on_termination = "true"
  }

  ebs_block_device = {
    volume_size           = "30"
    volume_type           = "gp2"
    delete_on_termination = "true"
    device_name           = "/dev/sdf"
  }

  tags {
    Name = "aws368-euw2-prod-web01"
    Role = "Prod Web 2"
  }

  volume_tags {
    Name          = "aws368-prod-web02:/dev/sda1"
    "qb:Schedule" = "{ \"SnapshotsOn\" : \"true\", \"SnapshotTime\" : \"9\", \"CopyPolicy\" : \"none\", \"DaysToKeep\" : \"30\" }"
  }

  lifecycle {
    ignore_changes = ["ami", "volume_tags"]
  }
}