############"IAM ROLE for ec2 instance ##################
resource "aws_iam_role" "ec2_s3" {
  name = "ec2_s3_access"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
  }
]
}
EOF
}

#### Read and write permissions on specified s3 buckets ####
resource "aws_iam_role_policy" "iam_policy" {
  name = "s3_rw"
  role = "${aws_iam_role.ec2_s3.id}"

  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListObjects",
        "s3:ListBucket",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*",
        "arn:aws:s3:::${var.logs_bucket}/*",
        "arn:aws:s3:::${var.logs_bucket}"
      ]
    }
  ]
  }
EOF
}
