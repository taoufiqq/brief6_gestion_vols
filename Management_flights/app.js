const express = require('express')
const bodyParser = require('body-parser');
const mysql = require('mysql');
const path = require('path');
const  ejs = require('ejs');

const app = express()
const port = 3000



const searchRoutes = require("./routers/search");




// configure middleware
app.set('views', __dirname + '/views'); // set express to look in this folder to render our view
app.set('view engine', 'ejs'); // configure template engine
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json()); // parse form data client



//------------------------------------ Routes Parts ----------------------------------//
app.use("/search",searchRoutes);

//------------------------------------ (HomeRoute) ----------------------------------//



app.get('/', (req, res) => {
  
    res.render('index')
 
 });






app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})