"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CdkAppStack = void 0;
const aws_cdk_lib_1 = require("aws-cdk-lib");
const ec2 = require("aws-cdk-lib/aws-ec2");
class CdkAppStack extends aws_cdk_lib_1.Stack {
    constructor(scope, id, props) {
        super(scope, id, props);
        this.createVpc = (vpcName, vpcCidr, subnetName) => {
            return new ec2.Vpc(this, vpcName, {
                cidr: vpcCidr,
                natGateways: 0,
                subnetConfiguration: [
                    { name: subnetName, cidrMask: 24, subnetType: ec2.SubnetType.PUBLIC },
                ],
            });
        };
        const vpc = this.createVpc('my-cdk-vpc', '10.0.0.0/16', 'public-subnet');
    }
}
exports.CdkAppStack = CdkAppStack;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY2RrLWFwcC1zdGFjay5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbImNkay1hcHAtc3RhY2sudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7O0FBQUEsNkNBQWdEO0FBRWhELDJDQUEyQztBQUczQyxNQUFhLFdBQVksU0FBUSxtQkFBSztJQUNwQyxZQUFZLEtBQWdCLEVBQUUsRUFBVSxFQUFFLEtBQWtCO1FBQzFELEtBQUssQ0FBQyxLQUFLLEVBQUUsRUFBRSxFQUFFLEtBQUssQ0FBQyxDQUFDO1FBSzFCLGNBQVMsR0FDUCxDQUFDLE9BQWUsRUFBRSxPQUFlLEVBQUUsVUFBa0IsRUFBRSxFQUFFO1lBQ3ZELE9BQU8sSUFBSSxHQUFHLENBQUMsR0FBRyxDQUFDLElBQUksRUFBRSxPQUFPLEVBQUU7Z0JBQ2hDLElBQUksRUFBRSxPQUFPO2dCQUNiLFdBQVcsRUFBRSxDQUFDO2dCQUNkLG1CQUFtQixFQUFFO29CQUNuQixFQUFFLElBQUksRUFBRSxVQUFVLEVBQUUsUUFBUSxFQUFFLEVBQUUsRUFBRSxVQUFVLEVBQUUsR0FBRyxDQUFDLFVBQVUsQ0FBQyxNQUFNLEVBQUU7aUJBQ3RFO2FBQ0YsQ0FBQyxDQUFDO1FBQ0wsQ0FBQyxDQUFDO1FBWkYsTUFBTSxHQUFHLEdBQUcsSUFBSSxDQUFDLFNBQVMsQ0FBQyxZQUFZLEVBQUUsYUFBYSxFQUFFLGVBQWUsQ0FBQyxDQUFBO0lBQzFFLENBQUM7Q0FZRjtBQWpCRCxrQ0FpQkMiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgeyBTdGFjaywgU3RhY2tQcm9wcyB9IGZyb20gJ2F3cy1jZGstbGliJztcbmltcG9ydCB7IENvbnN0cnVjdCB9IGZyb20gJ2NvbnN0cnVjdHMnO1xuaW1wb3J0ICogYXMgZWMyIGZyb20gJ2F3cy1jZGstbGliL2F3cy1lYzInO1xuaW1wb3J0ICogYXMgY2RrIGZyb20gJ2F3cy1jZGstbGliL2NvcmUnO1xuXG5leHBvcnQgY2xhc3MgQ2RrQXBwU3RhY2sgZXh0ZW5kcyBTdGFjayB7XG4gIGNvbnN0cnVjdG9yKHNjb3BlOiBDb25zdHJ1Y3QsIGlkOiBzdHJpbmcsIHByb3BzPzogU3RhY2tQcm9wcykge1xuICAgIHN1cGVyKHNjb3BlLCBpZCwgcHJvcHMpO1xuXG4gICAgY29uc3QgdnBjID0gdGhpcy5jcmVhdGVWcGMoJ215LWNkay12cGMnLCAnMTAuMC4wLjAvMTYnLCAncHVibGljLXN1Ym5ldCcpXG4gIH1cblxuICBjcmVhdGVWcGM6ICh2cGNOYW1lOiBzdHJpbmcsIHZwY0NpZHI6IHN0cmluZywgc3VibmV0TmFtZTogc3RyaW5nKSA9PiBlYzIuVnBjID1cbiAgICAodnBjTmFtZTogc3RyaW5nLCB2cGNDaWRyOiBzdHJpbmcsIHN1Ym5ldE5hbWU6IHN0cmluZykgPT4ge1xuICAgICAgcmV0dXJuIG5ldyBlYzIuVnBjKHRoaXMsIHZwY05hbWUsIHtcbiAgICAgICAgY2lkcjogdnBjQ2lkcixcbiAgICAgICAgbmF0R2F0ZXdheXM6IDAsXG4gICAgICAgIHN1Ym5ldENvbmZpZ3VyYXRpb246IFtcbiAgICAgICAgICB7IG5hbWU6IHN1Ym5ldE5hbWUsIGNpZHJNYXNrOiAyNCwgc3VibmV0VHlwZTogZWMyLlN1Ym5ldFR5cGUuUFVCTElDIH0sXG4gICAgICAgIF0sXG4gICAgICB9KTtcbiAgICB9O1xufVxuIl19