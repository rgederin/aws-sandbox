import * as sqs from 'aws-cdk-lib/aws-sqs';
import { Construct } from 'constructs';

export interface BmiQueueProps {
  name: string;
}

export class BmiQueue extends Construct {
  constructor(scope: Construct, id: string, props: BmiQueueProps) {
    super(scope, props.name.concat('-id'));
    const name = 'rgd-'.concat(props.name)
    
    return new sqs.Queue(this, id, {
      queueName: name,
    });
  }
}
