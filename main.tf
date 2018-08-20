##############################
#Terraform Sample Script for #
#Aditya                      #
##############################

terraform {
  backend "s3" {
    bucket         = "aws368tfstate"
    key            = "tfstate-test"
    encrypt        = true
    dynamodb_table = "Terraform-Test-Table"
    region         = "ap-southeast-2"
  }
}

provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

###############
# VPC Creation#
###############

resource "aws_vpc" "my_vpc" {
  cidr_block = "162.30.0.0/16"

  tags = {
    Name        = "aws368-euw2-prod-vpc-test"
    Owner       = "aditya"
    Environment = "prod"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags {
    Name = "aws368-euw2-prod-igw"
  }
}

########################
#Public Subnet Creation#
########################

resource "aws_subnet" "my_subnet1" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "162.30.0.0/24"
  availability_zone = "ap-southeast-2a"

  tags {
    Name = "aws368-euw-prod-pub-a-test"
    role = "Prod Public Subnet A"
  }
}

resource "aws_subnet" "my_subnet2" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "162.30.1.0/24"
  availability_zone = "ap-southeast-2b"

  tags {
    Name = "aws368-euw-prod-pub-b-test"
    role = "Prod Public Subnet B"
  }
}

#########################
#Private Subnet Creation#
#########################

resource "aws_subnet" "my_subnet3" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "162.30.8.0/24"
  availability_zone = "ap-southeast-2a"

  tags {
    Name = "aws172-euw2-prod-priv-data-a-test"
    role = "Private Data Subnet A"
  }
}

resource "aws_subnet" "my_subnet4" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "162.30.9.0/24"
  availability_zone = "ap-southeast-2b"

  tags {
    Name = "aws162-euw2-prod-priv-data-a-test"
    role = "Private Data Subnet B"
  }
}
