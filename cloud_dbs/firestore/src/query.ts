import { Firestore } from '@google-cloud/firestore';
import config from './config';

const init = async () => {
  const firestore = new Firestore({
    keyFilename: config.serviceAccountPath
  });

  const lastSavedBlockQuery = await firestore.collection('block').orderBy('number', 'desc')
    .limit(1)
    .get();

  console.log(lastSavedBlockQuery.docs[0].get('number'), lastSavedBlockQuery.size);

  const lastSavedBlockQueryOffset = await firestore.collection('block').orderBy('number', 'desc')
    .offset(10)
    .limit(1)
    .get();

  console.log(lastSavedBlockQueryOffset.docs[0].get('number'));
}

module.exports = init();