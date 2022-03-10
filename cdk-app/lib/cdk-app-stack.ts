import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { BmiVpc } from './vpc/vpc';
import { PublicSecurityGroup } from './security-groups/public-security-group';
import { PrivateSecurityGroup } from './security-groups/private-security-group';
import { PublicAutoScalingGroup } from './instances/autoscaling';
import { ApplicationLoadBalancer } from './balancer/alb';
import { BmiLogTable } from './storages/dynamodb-table';
import { BmiQueue } from './messaging/sqs-queue';
import { BmiNotification } from './messaging/sns-notification';
import { PrivateEC2Instance } from './instances/privateInstance';
import { RdsInstance } from './storages/rdsInstance';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';

export class CdkAppStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    const bmiAppVpc = new BmiVpc(this, 'rgd-bmi-vpc', {
      vpcCidr: '10.0.0.0/16',
    });

    const publicSecurityGroup = new PublicSecurityGroup(
      this,
      'rgd-public-security-group',
      { vpc: bmiAppVpc.vpc }
    );

    const privateSecurityGroup = new PrivateSecurityGroup(
      this,
      'rgd-private-security-group',
      { vpc: bmiAppVpc.vpc }
    );

    const publicAutoscalingGroup = new PublicAutoScalingGroup(
      this,
      'rgd-public-group',
      {
        vpc: bmiAppVpc.vpc,
        securityGroup: publicSecurityGroup.securityGroup,
        keyName: 'rgederin-lohika-2021-us-west-2',
      }
    );

    const privateEc2Instace = new PrivateEC2Instance(this, 'rgd-private-ec2', {
      vpc: bmiAppVpc.vpc,
      securityGroup: privateSecurityGroup.securityGroup,
      keyName: 'rgederin-lohika-2021-us-west-2',
    })


    const loadBalancer = new ApplicationLoadBalancer(this, 'rgd-load-balancer', {
      vpc: bmiAppVpc.vpc,
      asg: publicAutoscalingGroup.autoScalingGroup,
      securityGroup: publicSecurityGroup.securityGroup
    });

    const dynamodbTable = new BmiLogTable(this, 'rgd-bmi-log-table', {
      tableName: 'bmi-log-table',
      partitionKey: {
        name: 'id',
        type: dynamodb.AttributeType.STRING,
      },
    });

    const sqsQueue = new BmiQueue(this, 'rgd-bmi-queue', { name: 'rgd-bmi-queue' });

    const snsTopic = new BmiNotification(this, 'rgd-bmi-topic', {
      topicName: 'rgd-bmi-topic', resourceName: 'rgd-bmi-topic'
    })


    const rdsInstance = new RdsInstance(this, 'rgd-bmi-rds', {
      vpc: bmiAppVpc.vpc,
      securityGroup: privateSecurityGroup.securityGroup
    });

    dynamodbTable.dynamodbTable.grantFullAccess(publicAutoscalingGroup.autoScalingGroup);

    sqsQueue.sqs.grantSendMessages(publicAutoscalingGroup.autoScalingGroup);
    snsTopic.topic.grantPublish(publicAutoscalingGroup.autoScalingGroup);

    sqsQueue.sqs.grantConsumeMessages(privateEc2Instace.instance);
    snsTopic.topic.grantPublish(privateEc2Instace.instance);
  }
}
