const express = require('express');
const app = express();

app.get('/', (req, res) => {

    console.log(req.headers);
    console.log(req.ip)
    res.send({ok: 1});
});

app.listen(8080, () => {
    console.log('started at 8080');
})