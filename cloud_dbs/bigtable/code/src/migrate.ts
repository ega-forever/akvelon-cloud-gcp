import { Bigtable } from '@google-cloud/bigtable';
import config from './config';
import Web3 from 'web3';

const init = async () => {
  const bigtable = new Bigtable({
    keyFilename: config.serviceAccountPath
  });

  const instance = bigtable.instance(config.bigtableInstanceId as string);
  const blockTable = instance.table('block');
  const txTable = instance.table('tx');

  const [isBlockTableExists] = await blockTable.exists();
  const [isTxTableExists] = await txTable.exists();

  if (!isBlockTableExists) {
    await blockTable.create({
      families: ['numberhash']
    });
  }

  if (!isTxTableExists) {
    await txTable.create({
      families: ['tx']
    });
  }

  // @ts-ignore
  const web3 = new Web3(config.nodeUri);

  const lastBlockNumber = await web3.eth.getBlockNumber();
  console.log(`last block ${lastBlockNumber}`);


  const lastSavedBlockQuery = await blockTable.getRows({
    limit: 1
  });

  const lastSavedBlock = lastSavedBlockQuery[0].length ? lastSavedBlockQuery[0][0].data.numberhash.number[0].value : 0;

  for (let currentBlockNumber = lastSavedBlock + 1; currentBlockNumber++; lastBlockNumber) {

    const block = await web3.eth.getBlock(currentBlockNumber, true);

    const binaryNumberInverted = block.number.toString(2).padStart(32, '0').split('')
      .map(s => s === '1' ? '0' : '1')
      .join('');

    await blockTable.insert({
      key: `${binaryNumberInverted}#${block.timestamp}`,
      data: {
        numberhash: {
          number: block.number,
          hash: block.hash,
          timestamp: block.timestamp,
          txs_amount: block.transactions.length,
          // @ts-ignore
          tx_root: block.transactionsRoot
        }
      }
    });

    for (const tx of block.transactions) {
      await txTable.insert({
        key: `${block.number.toString().padStart(12, '0')}#${block.timestamp}#${tx.hash}`,
        data: { tx }
      })
    }

    console.log(`inserted block: ${block.number} / ${binaryNumberInverted}#${block.timestamp}`);

  }


}

module.exports = init();