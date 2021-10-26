import * as bunyan from 'bunyan';
import 'reflect-metadata';
import { Container } from 'typedi';
import * as TypeORM from 'typeorm';
import config from './config';
import { DEFAULT } from './constants/connections';
import { DI } from './constants/DI';
import { entities } from './models';
import CounterResolver from './resolvers/gql/counter/CounterResolver';
import CounterMutation from './resolvers/gql/counter/CounterMutation';

const logger = bunyan.createLogger({ name: 'core.rest' });

TypeORM.useContainer(Container);


const options: TypeORM.ConnectionOptions = {
  entities,
  name: DEFAULT,
  ...config.db as any
};
Container.set({ id: DI.logger, factory: () => logger });

module.exports.get = async (req, res) => {

  if (!TypeORM.getConnectionManager().connections.length) {
    await TypeORM.createConnection(options);
  }

  const counterResolver = Container.get(CounterResolver);
  const result = await counterResolver.get();
  return res.send({ result });
};

module.exports.increment = async (req, res) => {

  if (!TypeORM.getConnectionManager().connections.length) {
    await TypeORM.createConnection(options);
  }

  const counterMutation = Container.get(CounterMutation);
  const result = await counterMutation.increment();
  return res.send({ result });
};