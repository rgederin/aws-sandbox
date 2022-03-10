import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';
import { RemovalPolicy } from 'aws-cdk-lib';
import { Construct } from 'constructs';

export interface BmiLogTableProps {
  tableName: string;
  partitionKey: {
    name: string;
    type: dynamodb.AttributeType;
  };
  capacity?: number;
}

export class BmiLogTable extends Construct {
  public readonly dynamodbTable: dynamodb.Table;

  constructor(scope: Construct, id: string, props: BmiLogTableProps) {
    super(scope, 'rgd-'.concat(id));

    const { tableName, partitionKey, capacity } = props;

    this.dynamodbTable = new dynamodb.Table(this, id, {
      tableName: 'rgd-'.concat(tableName),
      partitionKey: partitionKey,
      readCapacity: capacity ? capacity : 5,
      writeCapacity: capacity ? capacity : 5,
      billingMode: dynamodb.BillingMode.PROVISIONED,
      removalPolicy: RemovalPolicy.DESTROY,
      pointInTimeRecovery: true,
    });
  }
}
