const express = require('express');
const Router = express.Router();
const db = require("../config/dbconnection");


Router.get('/', (req, res) => {


    let category_name = req.body.name_c;

    // const sql = "SELECT * from category";
    // db.query(sql, (err, rows) => {
    //     console.log(rows);
    //     if (err) throw err;
    //     res.render('category', {
    //         title: 'E-com Relation',
    //         rows: rows
    //     });

    // })
 res.render('details-vol.ejs');
});



module.exports = Router;