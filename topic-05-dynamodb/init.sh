#!/bin/bash

aws s3 mb s3://rgederin-bucket-week3

aws s3api put-bucket-versioning --bucket rgederin-bucket-week3 --versioning-configuration Status=Enabled

aws s3 cp rds-script.sql s3://rgederin-bucket-week3/

aws s3 cp dynamodb-script.sh s3://rgederin-bucket-week3/
