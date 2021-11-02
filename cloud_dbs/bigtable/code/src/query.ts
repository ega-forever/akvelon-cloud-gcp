import { Bigtable } from '@google-cloud/bigtable';
import config from './config';

const init = async () => {
  const bigtable = new Bigtable({
    keyFilename: config.serviceAccountPath
  });

  const instance = bigtable.instance(config.bigtableInstanceId as string);
  const blockTable = instance.table('block');

  const [lastSavedBlockQuery] = await blockTable.getRows({
    limit: 2
  });

  console.log('---------------------before update--------------')
  console.log(lastSavedBlockQuery[0].data.numberhash);

  console.log(lastSavedBlockQuery[0].id, lastSavedBlockQuery[0].data.numberhash.number);
  console.log(lastSavedBlockQuery[1].id, lastSavedBlockQuery[1].data.numberhash.number);
  console.log('---------------------after update--------------')

  await blockTable.insert({
    key: lastSavedBlockQuery[0].id,
    data: {
      numberhash: {
        number: lastSavedBlockQuery[0].data.numberhash.number[0].value
      }
    }
  });

  const [lastSavedBlockQueryUpdated] = await blockTable.row(lastSavedBlockQuery[0].id).get();

  console.log(lastSavedBlockQueryUpdated.data.numberhash)

}

module.exports = init();