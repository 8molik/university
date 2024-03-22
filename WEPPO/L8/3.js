const express = require('express');
const app = express();

app.set('view engine', 'ejs');
app.set('views', './views');

app.get('/', (req, res) => {
    const dynamicallyGeneratedData = 'Hello, world!';

    res.setHeader('Content-Disposition', 'attachment; filename=generatedFile.txt');
    res.setHeader('Content-Type', 'text/plain');

    res.send(dynamicallyGeneratedData);
});

app.listen(3000);
