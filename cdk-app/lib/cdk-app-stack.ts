import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';

import { Stack as stack } from 'aws-cdk-lib';
import { BmiVpc } from './vpc/vpc';
import { PublicSecurityGroup } from './security-groups/public';
import { PublicEC2Instance } from './instances/public';

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

    const publicEC21Az1 = new PublicEC2Instance(this, 'rgd-public-ec2-az1', {
      vpc: bmiAppVpc.vpc,
      availabilityZone: stack.of(this).availabilityZones[0],
      securityGroup: publicSecurityGroup.securityGroup,
      keyName: 'rgederin-lohika-2021-us-west-2',
    });

    const publicEC21Az2 = new PublicEC2Instance(this, 'rgd-public-ec2-az2', {
      vpc: bmiAppVpc.vpc,
      availabilityZone: stack.of(this).availabilityZones[1],
      securityGroup: publicSecurityGroup.securityGroup,
      keyName: 'rgederin-lohika-2021-us-west-2',
    });
    // const s3Role = this.createRole(
    //   's3-readonly-role',
    //   'AmazonS3ReadOnlyAccess'
    // );

    // const publicEc2 = this.createT2MicroEc2(
    //   'cdk-public-ec2',
    //   vpc,
    //   ec2.SubnetType.PUBLIC,
    //   s3Role,
    //   securityGroup,
    //   linuxAmi,
    //   'rgederin-lohika-2021-us-west-2'
    // );

    // const userDataScript = readFileSync(
    //   './scripts/public_user_data.sh',
    //   'utf8'
    // );
    // publicEc2.addUserData(userDataScript);
  }

  // createRole = (roleName: string, policyName: string): iam.Role => {
  //   return new iam.Role(this, roleName, {
  //     assumedBy: new iam.ServicePrincipal('ec2.amazonaws.com'),
  //     managedPolicies: [iam.ManagedPolicy.fromAwsManagedPolicyName(policyName)],
  //   });
  // };
}
