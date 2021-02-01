#!/bin/bash

aws sqs send-message --queue-url https://sqs.us-west-1.amazonaws.com/530260462866/sqs_queue --message-body 'rgederin sqs' --region us-west-1

aws sqs receive-message --queue-url https://sqs.us-west-1.amazonaws.com/530260462866/edu-lohika-training-aws-sqs-queue --region us-west-1
