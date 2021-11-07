import * as bunyan from 'bunyan';
import 'reflect-metadata';
import { Container } from 'typedi';
import * as TypeORM from 'typeorm';
import config from '../shared/config';
import { DEFAULT } from '../shared/constants/connections';
import { entities } from '../shared/models';
import { Message, PubSub } from '@google-cloud/pubsub';
import { Counter } from '../shared/models/counter/Counter';

const logger = bunyan.createLogger({ name: 'increment.worker' });

TypeORM.useContainer(Container);

const bootstrap = async () => {

  const options: TypeORM.ConnectionOptions = {
    entities,
    name: DEFAULT,
    ...config.db as any
  };

  await TypeORM.createConnection(options);

  const pubsub = new PubSub({
    projectId: config.googlePubSub.projectId,
    keyFilename: config.googlePubSub.credentials
  });

  const subscriptionPath = `projects/${config.googlePubSub.projectId}/subscriptions/${config.googlePubSub.subscriptions.increment}`;
  const [subscription] = await pubsub.subscription(subscriptionPath).get();
  const counterRepository = TypeORM.getRepository(Counter);

  subscription.on('message', async (message: Message) => {
    try {
      const packet: { increment: number } = JSON.parse(message.data.toString());
      const counter: Counter = await counterRepository.findOne();

      if (!counter) {
        const item = counterRepository.create();
        item.count = packet.increment;
        await counterRepository.save(item);
      } else {
        await counterRepository.increment({}, 'count', packet.increment);
      }

      logger.info(`incremented on ${packet.increment}`);
      message.ack();
    } catch (e) {
      logger.error(e);
    }
  });
};

bootstrap().catch((err) => {
  logger.error(err);
  process.exit(0);
});
