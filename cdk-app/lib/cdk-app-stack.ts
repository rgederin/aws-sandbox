import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { BmiVpc } from './vpc/vpc';
import { PublicSecurityGroup } from './security-groups/public';
import { PublicAutoScalingGroup } from './instances/autoscaling';
import { ApplicationLoadBalancer } from './balancer/alb';

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

    const publicAutoscalingGroup = new PublicAutoScalingGroup(
      this,
      'rgd-public-group',
      {
        vpc: bmiAppVpc.vpc,
        securityGroup: publicSecurityGroup.securityGroup,
        keyName: 'rgederin-lohika-2021-us-west-2',
      }
    );

    const loadBalancer = new ApplicationLoadBalancer(this, 'rgd-load-balancer', {
      vpc: bmiAppVpc.vpc,
      asg: publicAutoscalingGroup.autoScalingGroup,
      securityGroup: publicSecurityGroup.securityGroup
    });
  }

  // createRole = (roleName: string, policyName: string): iam.Role => {
  //   return new iam.Role(this, roleName, {
  //     assumedBy: new iam.ServicePrincipal('ec2.amazonaws.com'),
  //     managedPolicies: [iam.ManagedPolicy.fromAwsManagedPolicyName(policyName)],
  //   });
  // };
}
