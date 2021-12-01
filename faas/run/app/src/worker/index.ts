import * as bunyan from 'bunyan';
import 'reflect-metadata';
import { Container } from 'typedi';
import * as TypeORM from 'typeorm';
import config from '../shared/config';
import { DEFAULT } from '../shared/constants/connections';
import { entities } from '../shared/models';
import { Counter } from '../shared/models/counter/Counter';
import * as express from 'express';
import * as bodyParser from 'body-parser';

const app = express();
app.use(bodyParser.json({ limit: '3mb' }));
app.use(bodyParser.urlencoded({
  extended: true
}));

const logger = bunyan.createLogger({ name: 'increment.worker' });

TypeORM.useContainer(Container);

const options: TypeORM.ConnectionOptions = {
  entities,
  name: DEFAULT,
  ...config.db as any
};

app.post('/', async (req, res) => {

  const isConnected = TypeORM.getConnectionManager().has(DEFAULT);

  if (!isConnected) {
    await TypeORM.createConnection(options);
  }

  if (!req.body) {
    logger.error({ error: 0 });
    res.status(400).send({ error: 0 });
    return;
  }
  if (!req.body.message) {
    logger.error({ error: 1 });
    res.status(400).send({ error: 1 });
    return;
  }

  const counterRepository = TypeORM.getRepository(Counter);

  try {

    const originatorMessage = Buffer.from(req.body.message.data, "base64").toString().trim();
    const packet: { increment: number } = JSON.parse(originatorMessage);
    const counter: Counter = await counterRepository.findOne();

    if (!counter) {
      const item = counterRepository.create();
      item.count = packet.increment;
      await counterRepository.save(item);
    } else {
      await counterRepository.increment({}, 'count', packet.increment);
    }

    logger.info(`incremented on ${packet.increment}`);
    res.status(204).send();
  } catch (e) {
    logger.error(e);
  }
});


app.listen(config.rest.port, () => {
  logger.info(`Server ready on port ${config.rest.port}`);
});
