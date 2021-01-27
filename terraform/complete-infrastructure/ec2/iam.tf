resource "aws_iam_instance_profile" "ec2_instance_profile" {
  role = aws_iam_role.ec2_iam_role.name
}

resource "aws_iam_role" "ec2_iam_role" {
  path = "/"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  role = aws_iam_role.ec2_iam_role.id

  policy = <<-EOF
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
      },
      {
        "Action": [
          "dynamoDb:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}


