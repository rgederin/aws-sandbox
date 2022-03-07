import { Template, Capture } from 'aws-cdk-lib/assertions';
import * as cdk from 'aws-cdk-lib';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';
import { BmiLogTable } from '../lib/storages/dynamodb-table';

test('Bmi DynamoDb Table Created', () => {
  const stack = new cdk.Stack();

  new BmiLogTable(stack, 'TestBmiDynamoDbTable', {
    tableName: 'bmi-log-table',
    partitionKey: {
      name: 'id',
      type: dynamodb.AttributeType.STRING,
    },
  });

  const template = Template.fromStack(stack);
  template.resourceCountIs('AWS::DynamoDB::Table', 1);
});

test('Bmi DynamoDb Table Created With Default Settings', () => {
  const stack = new cdk.Stack();

  new BmiLogTable(stack, 'TestBmiDynamoDbTable', {
    tableName: 'bmi-log-table',
    partitionKey: {
      name: 'id',
      type: dynamodb.AttributeType.STRING,
    },
  });

  const template = Template.fromStack(stack);
  template.hasResourceProperties('AWS::DynamoDB::Table', {
    TableName: 'rgd-bmi-log-table',
    ProvisionedThroughput: {
      ReadCapacityUnits: 5,
      WriteCapacityUnits: 5,
    },
  });
});

test('Bmi DynamoDb Table Created With Default Settings', () => {
  const stack = new cdk.Stack();

  new BmiLogTable(stack, 'TestBmiDynamoDbTable', {
    tableName: 'bmi-log-table',
    partitionKey: {
      name: 'id',
      type: dynamodb.AttributeType.STRING,
    },
  });

  const template = Template.fromStack(stack);
  template.hasResourceProperties('AWS::DynamoDB::Table', {
    TableName: 'rgd-bmi-log-table',
    ProvisionedThroughput: {
      ReadCapacityUnits: 5,
      WriteCapacityUnits: 5,
    },
  });
});

test('Bmi DynamoDb Table Created With Custom Settings', () => {
  const stack = new cdk.Stack();

  new BmiLogTable(stack, 'TestBmiDynamoDbTable', {
    tableName: 'bmi-log-table',
    partitionKey: {
      name: 'id',
      type: dynamodb.AttributeType.STRING,
    },
    capacity: 10,
  });

  const template = Template.fromStack(stack);
  template.hasResourceProperties('AWS::DynamoDB::Table', {
    TableName: 'rgd-bmi-log-table',
    ProvisionedThroughput: {
      ReadCapacityUnits: 10,
      WriteCapacityUnits: 10,
    },
  });
});
