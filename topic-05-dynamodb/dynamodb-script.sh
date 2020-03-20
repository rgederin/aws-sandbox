#!/bin/bash

aws dynamodb list-tables --region us-east-1

echo "put (key -> '1' value -> 'Vova')"
aws dynamodb put-item --table-name "course-trainers-dynamo-db" --item '{ "LookupKey": { "N": "1" }, "Value": { "S": "Vova" } }' --region us-east-1
echo "put (key -> '2' value -> 'Alex')"
aws dynamodb put-item --table-name "course-trainers-dynamo-db" --item '{ "LookupKey": { "N": "2" }, "Value": { "S": "Alex" } }' --region us-east-1

echo "get value with key -> '1'"
aws dynamodb get-item --table-name "course-trainers-dynamo-db" --key '{ "LookupKey": { "N": "1" } }' --region us-east-1
echo "get value with key -> '2'"
aws dynamodb get-item --table-name "course-trainers-dynamo-db" --key '{ "LookupKey": { "N": "2" } }' --region us-east-1

echo "get not existed value"
aws dynamodb get-item --table-name "course-trainers-dynamo-db" --key '{ "LookupKey": { "N": "3" } }' --region us-east-1
