#############################
#RDS-MYSQL Database Creation#
#############################

resource "aws_db_instance" "rds" {
  allocated_storage          = 10
  storage_type               = "gp2"
  engine                     = "mysql"
  engine_version             = "5.6.39"
  instance_class             = "db.t2.micro"
  name                       = "aws368proddb01"
  username                   = ""
  password                   = ""
  db_subnet_group_name       = "${aws_db_subnet_group.aws368-euw2-prod-db01-sng.id}"
  parameter_group_name       = "${aws_db_parameter_group.aws368-prod-db01-paramgrp.id}"
  port                       = "3306"
  storage_encrypted          = "false"
  copy_tags_to_snapshot      = "true"
  publicly_accessible        = "false"
  auto_minor_version_upgrade = "true"
  final_snapshot_identifier  = "FINAL-aws368-prod-db01"
  monitoring_interval        = "0"
  maintenance_window         = "sat:16:00-sat:18:00"
  backup_window              = "14:00-16:00"
  backup_retention_period    = "30"
  vpc_security_group_ids     = ["${aws_security_group.db-sg.id}"]

  tags {
    Name             = "aws368-prod-db01"
    Environment      = "Prod"
    Management       = "Test"
    Application-type = "database"
    Solution         = "solution"
  }
}

##############
#RDS Snapshot#
##############

resource "aws_db_snapshot" "aws368-euw2-prod-db01-snapshot" {
  db_instance_identifier = "${aws_db_instance.rds.id}"
  db_snapshot_identifier = "aws368-euw2-prod-db01-snapshot-test"
}

##################
#RDS Subnet Group#
##################

resource "aws_db_subnet_group" "aws368-euw2-prod-db01-sng" {
  name        = "aws368-apse2-prod-db-sng"
  description = "aws368 RDS Subnet Group"
  subnet_ids  = ["${aws_subnet.my_subnet3.id}", "${aws_subnet.my_subnet4.id}"]

  tags {
    Name   = "aws368-apse2-prod-db-sng"
    Role   = "Prod"
    Sample = "Test"
  }
}

########################################
#RDS Parameter Group- Parameters Config#
########################################

resource "aws_db_parameter_group" "aws368-prod-db01-paramgrp" {
  name        = "aws368-prod-db01-paramgrp"
  description = "RDS Parameter Group for aws368-prod-db01"
  family      = "mysql5.6"

  parameter {
    name  = "log_output"
    value = "FILE"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "33554432"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "wait_timeout"
    value = "120"
  }

  tags {
    Name   = "aws368-prod-db01-paramgrp"
    Role   = "Prod"
    Sample = "Test"
  }
}