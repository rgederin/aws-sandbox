#!/bin/bash
aws s3api get-object --bucket ${s3_bucket_name} --key ${s3_sql_script_file_name} ${s3_sql_script_file_name}
aws s3api get-object --bucket ${s3_bucket_name} --key ${s3_dynamodb_script_file_name} ${s3_dynamodb_script_file_name}
