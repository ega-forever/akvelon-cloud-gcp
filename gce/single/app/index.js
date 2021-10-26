const express = require('express');
const bunyan = require('bunyan');
const app = express();

const port = process.env.PORT || 80;
const logger = bunyan.createLogger({name: 'rest.api', level: 30});

app.get('/', (req, res) => {
    logger.info({ip: req.ip, path: '/'});
    res.send({ok: 1});
});

app.get('/long', async (req, res) => {
    await new Promise(res => setTimeout(res, 5000));
    res.send({ok: 2});
});

app.listen(port, () => {
    console.log(`started at ${port}`);
});