#!/bin/bash

#Create text file
echo "rgederin txt file on s3" > rgederin-s3-file.txt

# Create AWS S3 bucket
aws s3 mb s3://rgederin-bucket

# Add verioning to S3 bucket
aws s3api put-bucket-versioning --bucket rgederin-bucket --versioning-configuration Status=Enabled

#Upload file to S3 and give full permissions to everyone
aws s3 cp rgederin-s3-file.txt s3://rgederin-bucket/
