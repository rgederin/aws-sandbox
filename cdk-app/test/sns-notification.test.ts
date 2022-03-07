import { Template, Capture } from 'aws-cdk-lib/assertions';
import * as cdk from 'aws-cdk-lib';
import { BmiNotification } from '../lib/messaging/sns-notification';

test('Bmi Topic Created', () => {
  const stack = new cdk.Stack();

  new BmiNotification(stack, 'TestBmiTopic', {
    resourceName: 'bmi-topic',
    topicName: 'bmi-topic'
  });

  const template = Template.fromStack(stack);
  template.resourceCountIs('AWS::SNS::Topic', 1);
});

test('Bmi Topic Created With Correct Name', () => {
  const stack = new cdk.Stack();

  new BmiNotification(stack, 'TestBmiTopic', {
    resourceName: 'bmi-topic',
    topicName: 'bmi-topic'
  });

  const template = Template.fromStack(stack);
  template.hasResourceProperties('AWS::SNS::Topic', {
    DisplayName: 'rgd-bmi-topic',
    TopicName: 'rgd-bmi-topic'
  });
});
