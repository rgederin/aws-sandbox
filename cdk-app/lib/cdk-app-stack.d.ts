import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
export declare class CdkAppStack extends Stack {
    constructor(scope: Construct, id: string, props?: StackProps);
    createVpc: (vpcName: string, vpcCidr: string, subnetName: string) => ec2.Vpc;
}
