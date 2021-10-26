const express = require('express');
const bunyan = require('bunyan');
const {LoggingBunyan} = require('@google-cloud/logging-bunyan');
const profiler = require('@google-cloud/profiler');
const packageJson = require('./package.json');

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

profiler.start({
    serviceContext: {
        service: 'rest.api',
        version: packageJson.version,
        enableCanary: false
    }
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
    logger.info(`started at ${port}`);
});