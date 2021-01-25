resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.week5-iam-role.name
}

resource "aws_iam_role" "week5-iam-role" {
  name = "week5-iam-role"

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

resource "aws_iam_role_policy" "s3_sqs_sns_bucket_policy" {
  name = "s3_bucket_policy"
  role = aws_iam_role.week5-iam-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
     {
        "Action": [
          "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "sqs:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "sns:*",
        "Resource": "*"
      }
    ]
}
  EOF
}

