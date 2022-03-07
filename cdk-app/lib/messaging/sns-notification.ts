import * as sns from 'aws-cdk-lib/aws-sns';
import { Construct } from 'constructs';

export interface BmiNotificationProps {
  topicName: string;
  resourceName: string;
}

export class BmiNotification extends Construct {
  constructor(scope: Construct, id: string, props: BmiNotificationProps) {
    super(scope, props.resourceName.concat('-id'));

    const topicName = 'rgd-'.concat(props.topicName);
    const resourceName = 'rgd-'.concat(props.resourceName);

    return new sns.Topic(this, id, {
      displayName: resourceName,
      topicName: topicName,
    });
  }
}
