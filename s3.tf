#############################
#Creating S3 Bucket for Logs#
#############################

resource "aws_s3_bucket" "aws162-euw2-elb-logs" {
  bucket = "aws162-euw2-elb-logs-test"

  tags {
    Name        = "aws162-euw2-elb-logs-sample"
    Environment = "Sample"
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = 183
    }
  }
}

resource "aws_s3_bucket_policy" "aws162-euw2-elb-logs-policy" {
  bucket = "${aws_s3_bucket.aws162-euw2-elb-logs.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "prod-elb-log-policy-test",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::aws162-euw2-elb-logs-test/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "8.8.8.8/32"}
      }
    }
  ]
}
POLICY
}
