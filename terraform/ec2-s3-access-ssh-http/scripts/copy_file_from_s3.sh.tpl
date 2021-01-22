#!/bin/bash
aws s3api get-object --bucket ${s3_bucket_name} --key ${s3_file_key} ${destination_file_name}