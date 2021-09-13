import { Firestore } from '@google-cloud/firestore';
import config from './config';
import Web3 from 'web3';

const init = async () => {
  const firestore = new Firestore({
    keyFilename: config.serviceAccountPath
  });

  // @ts-ignore
  const web3 = new Web3(config.nodeUri);

  const lastBlockNumber = await web3.eth.getBlockNumber();


 console.log(`last block ${lastBlockNumber}`);

  const lastSavedBlockQuery = await firestore.collection('block').orderBy('number', 'desc')
    .limit(1)
    .get();

  const lastSavedBlock = lastSavedBlockQuery.docs.length ? lastSavedBlockQuery.docs[0].get('number') : 0;


  for (let currentBlockNumber = lastSavedBlock + 1; currentBlockNumber++; lastBlockNumber) {

    const block = await web3.eth.getBlock(currentBlockNumber, true);

    await firestore.collection('block').doc(block.number.toString()).set({
      number: block.number,
      hash: block.hash,
      timestamp: block.timestamp,
      txs_amount: block.transactions.length,
      // @ts-ignore
      tx_root: block.transactionsRoot
    });

    for (const tx of block.transactions) {
      await firestore.collection('tx').doc(tx.hash).set(tx);
    }

    console.log(`inserted block: ${block.number}`);

  }

}

module.exports = init();