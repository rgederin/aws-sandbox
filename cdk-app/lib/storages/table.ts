import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';
import * as cdk from 'aws-cdk-lib/core';
import { Construct } from 'constructs';

export interface BmiLogTableProps {
  tableName: string;
  partitionKey: {
    name: string;
    type: dynamodb.AttributeType;
  };
  capacity?: number;
  billingMode?: dynamodb.BillingMode;
  removalPolicy?: cdk.RemovalPolicy;
  pointInTimeRecovery?: boolean;
}

export class BmiLogTable extends Construct {
  constructor(scope: Construct, id: string, props: BmiLogTableProps) {
    super(scope, 'rgd-'.concat(id));

    const {
      tableName,
      partitionKey,
      capacity,
      billingMode,
      removalPolicy,
      pointInTimeRecovery,
    } = props;

    return new dynamodb.Table(this, id, {
      tableName: 'rgd-'.concat(tableName),
      partitionKey: partitionKey,
      readCapacity: capacity ? capacity : 5,
      writeCapacity: capacity ? capacity : 5,
      billingMode: billingMode ? billingMode : dynamodb.BillingMode.PROVISIONED,
      removalPolicy: removalPolicy ? removalPolicy : cdk.RemovalPolicy.DESTROY,
      pointInTimeRecovery: pointInTimeRecovery ? pointInTimeRecovery : true,
    });
  }
}
