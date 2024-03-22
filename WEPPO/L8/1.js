const http = require('http');
const express = require('express');
const app = express();
const multer = require('multer');
const path = require('path');

app.set('view engine', 'ejs');
app.set('views', './views');

const storage = multer.diskStorage({
    destination: (req, fun, call) => {
        call(null, './files');
    },
    filename: (res, file, call) => {
        console.log(file);
        call(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({storage : storage});

app.get('/upload', (req, res) => {
    res.render('upload');
});

app.post('/upload', upload.single('file'), (req, res) => {
    res.send('File uploaded');
});


http.createServer(app).listen(3000);