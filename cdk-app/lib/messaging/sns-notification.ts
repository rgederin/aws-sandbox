import * as sns from 'aws-cdk-lib/aws-sns';
import * as subscriptions from 'aws-cdk-lib/aws-sns-subscriptions';

import { Construct } from 'constructs';

export interface BmiNotificationProps {
  topicName: string;
  resourceName: string;
}

export class BmiNotification extends Construct {
  public readonly topic: sns.Topic;

  constructor(scope: Construct, id: string, props: BmiNotificationProps) {
    super(scope, props.resourceName.concat('-id'));

    const topicName = 'rgd-'.concat(props.topicName);
    const resourceName = 'rgd-'.concat(props.resourceName);

    this.topic = new sns.Topic(this, id, {
      displayName: resourceName,
      topicName: topicName,
    });

    this.topic.addSubscription(new subscriptions.EmailSubscription('rgederin@lohika.com'));
  }
}
