import { Template, Capture } from 'aws-cdk-lib/assertions';
import * as cdk from 'aws-cdk-lib';
import { BmiQueue } from '../lib/messaging/queue';

test('Bmi Queue Created', () => {
  const stack = new cdk.Stack();

  new BmiQueue(stack, 'TestBmiQueue', {
    name: 'test-queue',
  });

  const template = Template.fromStack(stack);
  template.resourceCountIs('AWS::SQS::Queue', 1);
});

test('Bmi Queue Created With Correct Name', () => {
  const stack = new cdk.Stack();

  new BmiQueue(stack, 'TestBmiQueue', {
    name: 'test-queue',
  });

  const template = Template.fromStack(stack);
  template.hasResourceProperties('AWS::SQS::Queue', {
    QueueName: 'rgd-test-queue',
  });
});
