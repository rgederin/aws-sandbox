#!/bin/bash

aws sns publish --topic arn:aws:sns:us-west-1:530260462866:sns_topic --message 'hello from ruslan aws' --region us-west-1
