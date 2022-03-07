import * as cdk from 'aws-cdk-lib/core';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as iam from 'aws-cdk-lib/aws-iam';
import { Construct } from 'constructs';

interface PublicEC2InstanceProps {
  vpc: ec2.Vpc;
  availabilityZone: string;
  securityGroup: ec2.SecurityGroup;
  role?: iam.Role;
  keyName: string;
}

export class PublicEC2Instance extends Construct {
  constructor(scope: Construct, id: string, props: PublicEC2InstanceProps) {
    super(scope, id);

    const { vpc, availabilityZone, securityGroup, role, keyName } = props;

    const linuxAmi = new ec2.AmazonLinuxImage({
      generation: ec2.AmazonLinuxGeneration.AMAZON_LINUX_2,
    });

    return new ec2.Instance(this, id, {
      vpc,
      vpcSubnets: {
        subnetType: ec2.SubnetType.PUBLIC,
      //  availabilityZones: [availabilityZone],
      },
      role: role,
      securityGroup: securityGroup,
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.T2,
        ec2.InstanceSize.MICRO
      ),
      machineImage: linuxAmi,
      keyName: keyName,
    });
  }
}
