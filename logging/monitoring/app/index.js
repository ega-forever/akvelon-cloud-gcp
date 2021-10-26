const express = require('express');
const bunyan = require('bunyan');
const {LoggingBunyan} = require('@google-cloud/logging-bunyan');
const app = express();

const port = process.env.PORT || 80;

const loggingBunyan = new LoggingBunyan();

const logger = bunyan.createLogger({
    // The JSON payload of the log as it appears in Cloud Logging
    // will contain "name": "my-service"
    name: 'rest.api',
    streams: [
        // Log to the console at 'info' and above
        {stream: process.stdout, level: 'info'},
        // And log to Cloud Logging, logging at 'info' and above
        loggingBunyan.stream('info'),
    ],
});

app.get('/', (req, res) => {
    logger.info({ip: req.ip, path: '/'});
    res.send({ok: 1});
});

app.get('/error', (req, res) => {
    logger.error({ip: req.ip, path: '/error', error: 1});
    res.send({ok: 0});
});

app.listen(port, () => {
    console.log(`started at ${port}`);
});