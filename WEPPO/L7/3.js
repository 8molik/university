var http = require("http");
var express = require("express");
var app = express();
app.set("view engine", "ejs");
app.set("views", "./views");
app.use(express.urlencoded({ extended: true }));

app.get("/", (req, res) => {
    res.render("index", {
        name: "",
        surname: "",
        field: ""
    });
});

app.post("/", (req, res) => {
    var name = req.body.name;
    var surname = req.body.surname;
    var field = req.body.field;
    var taskScores = [];

    // Extract task scores from the request body
    for (let i = 1; i <= 10; i++) {
        var taskScore = req.body['task' + i];
        taskScores.push(taskScore);
    }

    if (!surname || !name || !taskScores || !field) {
        res.render("index", {
            name: name,
            surname: surname,
            field: field,
            message: "Uzupełnij wszystkie pola."
        });
    }
    else {
        res.redirect("/print?name=" + name +
            "&surname=" + surname +
            "&field=" + field +
            "&taskScores=" + JSON.stringify(taskScores));
    }
});

app.get("/print", (req, res) => {
    var name = req.query.name;
    var surname = req.query.surname;
    var field = req.query.field;
    var taskScores = JSON.parse(req.query.taskScores || '[]');

    res.render("print", { name, surname, field, taskScores });
});

http.createServer(app).listen(3001);
