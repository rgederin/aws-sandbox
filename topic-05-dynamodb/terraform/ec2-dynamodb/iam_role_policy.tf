resource "aws_iam_role_policy" "s3_bucket_policy" {
  name = "s3_bucket_policy"
  role = aws_iam_role.iam-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}
  EOF
}