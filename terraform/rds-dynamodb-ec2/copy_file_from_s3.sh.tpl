#!/bin/bash
aws s3api get-object --bucket rgederin-bucket-week3 --key rds-script.sql rds-script.sql
aws s3api get-object --bucket rgederin-bucket-week3 --key dynamodb-script.sh dynamodb-script.sh
