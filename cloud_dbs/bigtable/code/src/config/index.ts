import * as dotenv from 'dotenv';

dotenv.config();

export default {
  serviceAccountPath: process.env.SERVICE_ACCOUNT_PATH,
  nodeUri: process.env.NODE_URI,
  bigtableInstanceId: process.env.BIGTABLE_INSTANCE_ID
}