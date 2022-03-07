import * as cdk from 'aws-cdk-lib/core';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import { Construct } from 'constructs';

export interface BmiVpcProps {
  vpcCidr: string;
}

export class BmiVpc extends Construct {
  public readonly vpc: ec2.Vpc;

  constructor(scope: Construct, id: string, props: BmiVpcProps) {
    super(scope, id);

    this.vpc = new ec2.Vpc(this, id, {
      cidr: props.vpcCidr,
      natGateways: 0,
      maxAzs: 2,
      subnetConfiguration: [
        {
          name: 'rgd-bmi-public-subnet',
          cidrMask: 24,
          subnetType: ec2.SubnetType.PUBLIC,
        },
        {
          name: 'rgd-bmi-private-subnet-1',
          cidrMask: 24,
          subnetType: ec2.SubnetType.PRIVATE_ISOLATED,
        },
      ],
    });
  }
}
