import * as dotenv from 'dotenv';

dotenv.config();

export default {
  rest: {
    port: process.env.PORT ? parseInt(process.env.PORT, 10) : 3001
  },
  logLevel: process.env.LOG_LEVEL ? parseInt(process.env.LOG_LEVEL, 10) : 50,
  db: {
    type: process.env.DB_TYPE || 'postgres',
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT ? parseInt(process.env.DB_PORT, 10) : 5432,
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DB || 'counter',
    logging: process.env.DB_LOGGING ? !!parseInt(process.env.DB_LOGGING, 10) : false,
    synchronize: process.env.DB_SYNC ? !!parseInt(process.env.DB_SYNC, 10) : true
  },
  googlePubSub: {
    projectId: process.env.GOOGLE_PUBSUB_PROJECT_ID,
    credentials: process.env.GOOGLE_PUBSUB_CREDENTIALS,
    topics: {
      increment: process.env.GOOGLE_PUBSUB_TOPIC_INCREMENT || 'app_increment'
    },
    subscriptions: {
      increment: process.env.GOOGLE_PUBSUB_SUBSCRIPTION_INCREMENT || 'app_increment_subscription'
    }
  },
  gql: {
    introspection: process.env.GQL_INTROSPECTION ? !!parseInt(process.env.GQL_INTROSPECTION, 10) : false,
    playground: process.env.GQL_PLAYGROUND ? !!parseInt(process.env.GQL_PLAYGROUND, 10) : false
  }
};
