import { readFileSync } from 'fs';
import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as cdk from 'aws-cdk-lib/core';
import * as iam from 'aws-cdk-lib/aws-iam';

export class CdkAppStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    const vpc = this.createVpc('my-cdk-vpc', '10.0.0.0/16', 'public-subnet');
    const securityGroup = this.createSecurityGroup(
      'public-security-group',
      vpc
    );

    this.addIngressRule(securityGroup, 22, 'allow SSH access from anywhere');
    this.addIngressRule(securityGroup, 80, 'allow HTTP traffic from anywhere');
    this.addIngressRule(
      securityGroup,
      443,
      'allow HTTPS traffic from anywhere'
    );

    const s3Role = this.createRole(
      's3-readonly-role',
      'AmazonS3ReadOnlyAccess'
    );
    const linuxAmi = new ec2.AmazonLinuxImage({
      generation: ec2.AmazonLinuxGeneration.AMAZON_LINUX_2,
    });

    const publicEc2 = this.createT2MicroEc2(
      'cdk-public-ec2',
      vpc,
      ec2.SubnetType.PUBLIC,
      s3Role,
      securityGroup,
      linuxAmi,
      'rgederin-lohika-2021-us-west-2'
    );

    const userDataScript = readFileSync(
      './scripts/public_user_data.sh',
      'utf8'
    );
    publicEc2.addUserData(userDataScript);
  }

  createVpc = (vpcName: string, vpcCidr: string, subnetName: string): ec2.Vpc => {
    return new ec2.Vpc(this, vpcName, {
      cidr: vpcCidr,
      natGateways: 0,
      subnetConfiguration: [
        { name: subnetName, cidrMask: 24, subnetType: ec2.SubnetType.PUBLIC },
      ],
    });
  };

  createSecurityGroup = (sgName: string, vpc: ec2.Vpc) : ec2.SecurityGroup => {
    return new ec2.SecurityGroup(this, sgName, {
      vpc,
      allowAllOutbound: true,
    });
  };

  addIngressRule = (securityGroup: ec2.SecurityGroup, port: number, description: string) => {
    securityGroup.addIngressRule(
      ec2.Peer.anyIpv4(),
      ec2.Port.tcp(port),
      description
    );
  };

  createRole = (roleName: string, policyName: string) : iam.Role => {
    return new iam.Role(this, roleName, {
      assumedBy: new iam.ServicePrincipal('ec2.amazonaws.com'),
      managedPolicies: [iam.ManagedPolicy.fromAwsManagedPolicyName(policyName)],
    });
  };

  createT2MicroEc2 = (name: string, vpc: ec2.Vpc, subnetType: ec2.SubnetType, role: iam.Role, 
    securityGroup: ec2.SecurityGroup, ami: ec2.AmazonLinuxImage, keyName: string): ec2.Instance => {
    return new ec2.Instance(this, name, {
      vpc,
      vpcSubnets: {
        subnetType: subnetType,
      },
      role: role,
      securityGroup: securityGroup,
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.T2,
        ec2.InstanceSize.MICRO
      ),
      machineImage: ami,
      keyName: keyName,
    });
  };
}
