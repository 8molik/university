var http = require('http');
var express = require('express');
var app = express();

app.set('view engine', 'ejs');
app.set('views', './views');

app.get('/', (req, res) => {
    var radioList = [
            {id: 'option1', value: 'value1', text: 'element 1' },
            {id: 'option2', value: 'value2', text: 'element 2' },
        ]
    res.render('main', { radioList });
});

app.post('/submit', (req, res) => {
    console.log('Received POST request with data:', req.body);
    res.send('POST request received successfully!');
});

http.createServer(app).listen(3000);