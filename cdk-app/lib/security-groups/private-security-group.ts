import * as cdk from 'aws-cdk-lib/core';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import { Construct } from 'constructs';
import { Vpc } from 'aws-cdk-lib/aws-ec2';

interface PublicSecurityGroupProps {
    vpc: ec2.Vpc;
}

export class PrivateSecurityGroup extends Construct {
    public readonly securityGroup: ec2.SecurityGroup;

    constructor(scope: Construct, id: string, props: PublicSecurityGroupProps) {
        super(scope, id);

        this.securityGroup = new ec2.SecurityGroup(
            this,
            'rgd-private-security-group',
            {
                vpc: props.vpc,
                allowAllOutbound: true,
            }
        );

        this.securityGroup.addIngressRule(
            ec2.Peer.ipv4(props.vpc.vpcCidrBlock),
            ec2.Port.tcp(22),
            'allow SSH access from the instances within vpc'
        );

        this.securityGroup.addIngressRule(
            ec2.Peer.ipv4(props.vpc.vpcCidrBlock),
            ec2.Port.icmpPing(),
            'allow HTTP traffic from anywhere'
        );
    }
}
