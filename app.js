const express = require('express')
const bodyParser = require('body-parser');
const path = require('path');
const  ejs = require('ejs');
fs = require('fs');


const app = express()
const port = 3000



const searchRoutes = require("./routers/search");
app.use(express.static(path.join(__dirname, 'assets')));
app.use(express.static(path.join(__dirname, 'assets')));




// configure middleware
app.set('views', __dirname + '/views'); // set express to look in this folder to render our view
app.set('view engine', 'ejs'); // configure template engine
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json()); // parse form data client



//------------------------------------ Routes Parts ----------------------------------//
app.use("/",searchRoutes);

//------------------------------------ (HomeRoute) ----------------------------------//
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})