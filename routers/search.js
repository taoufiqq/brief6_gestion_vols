const express = require('express');
const router = express.Router();
const db = require("../config/dbconnection");

fs = require('fs');

router.get('/', (req, res) => {
    res.render('index')

});

router.get('/add', (req, res) => {
    res.render('addVol')

});
router.get('/payment', (req, res) => {
    res.render('payment')

});

router.get('/AdminVol', (req, res) => {
    res.render('AdminVol');
})
router.get('/reservation', (req, res) => {
    res.render('reservation');
})
router.get('/confirmation', (req, res) => {
    res.render('confirmation');
})
router.get('/login', (req, res) => {
    res.render('login');
})
router.get('/thanks', (req, res) => {
    res.render('thanks');
})
// search function   


router.post('/search/vols', function (req, res) {
    var str = {
        DepartVille: req.body.ville_depart,
        ArriveVille: req.body.ville_arrive,
        // DepartDate:req.body.date_depart,
        NbrPlaceReserve: req.body.nombrePlace

    }

    let check = 0;

    var rows2 = new Array();



    db.query('SELECT IdVol,ville_depart,ville_arrive,heur_depart,heur_arrive,date_depart,date_arrive,escale,nombrePlace FROM vols WHERE ville_depart LIKE "%' + str.DepartVille + '%" AND ville_arrive LIKE "%' + str.ArriveVille + '%"', function (err, rows, fields) {
        if (err) throw err;
        for (let i = 0; i < rows.length; i++) {


            if (str.NbrPlaceReserve > rows[i].nombrePlace) {
           } else {


                rows2.push(rows[i])
            }
        }
             res.render('details-vol.ejs', {
            rows: rows2,
            nbrPlace: str.NbrPlaceReserve

        });
    });
});

router.post("/authentification", (req, res) => {

    let nom = req.body.nom;
    let prenom = req.body.prenom;
    let email = req.body.email;
    let ntel = req.body.ntel;
    let idVol = req.body.idVol;
    let nbrPlace = req.body.nbrPlace;



    let query = "INSERT INTO `client` (Nom, Prenom, email,telephone) VALUES ('" + nom + "', '" + prenom + "', '" + email + "', '" + ntel + "')";
    db.query(query, (err, result) => {
        if (err) {
            return res.status(500).send(err);
        }

        let last = result.insertId
        db.query(`SELECT * FROM vols WHERE IdVol = ${idVol}`, function (err, rows, fields) {
            if (err) throw err;


            res.render('confirmation', {
                rows: rows,
                nbrPlace: nbrPlace,
                nom: nom,
                prenom: prenom,
                ntel: ntel,
                lastId: last,
                idVol: idVol

            });

        });


    });

});



router.post("/lastCheck", (req, res) => {

    let idVol = req.body.idVol;
    let idClient = req.body.idClient;
    let nbrPlace = req.body.nbrPlace;

    var today = new Date();
    var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    var dateResevation = date + ' ' + time;

    let query = "INSERT INTO reservation (IdClient, IdVol, nbrPlaceReserver,DateReservation) VALUES ('" + idClient + "', '" + idVol + "', '" + nbrPlace + "', '" + dateResevation + "')";
    db.query(query, (err, result) => {
        if (err) {
            return res.status(500).send(err);
           
            
        }
        res.render('payment', {
 
            IdRes:result.insertId,
            idClient:idClient
    
        });
   
    });
    


});

router.post("/payment", (req, res) => {

    let nom = req.body.nom;
    let CardNumber = req.body.card_Number;
    let DateExp = req.body.date_Exp;
    let Cvs = req.body.cvs;
    let Id_Res = req.body.idRes;
    let id_client = req.body.idClient;
 
  
    let query = "INSERT INTO `paiment` (idReservation,nom, cardNumber,dateExp, cvs ) VALUES ('" + Id_Res + "','" + nom + "', '" + CardNumber + "', '" + DateExp + "', '" + Cvs + "')";
    db.query(query, (err, result) => {
        if (err) {
            return res.status(500).send(err);
        }
     
        db.query(`SELECT v.ville_depart,v.ville_arrive,v.heur_depart,v.heur_arrive,v.date_depart,v.date_arrive,v.escale,c.Nom,c.Prenom,c.email,r.nbrPlaceReserver FROM vols AS v INNER JOIN client AS c INNER JOIN reservation AS r ON v.IdVol = r.IdVol WHERE r.IdReservation=${Id_Res} AND c.idClient = ${id_client}`, function (err, rows, fields) {
            if (err) throw err;


            res.render('thanks', {
                rows: rows,

            });

                    // write to a new file named 2pac.txt
fs.appendFileSync('history.txt',"\n\nNom et Prenom :" +  rows[0].Nom  +" " +  rows[0].Prenom  +" \nville de départ :" + rows[0].ville_depart + "\nville d’arrivé :"+ rows[0].ville_arrive + "\nl’heure départ :" + rows[0].heur_depart + "\nl’heure d’arrivé :" + rows[0].heur_arrive + "\nla date de départ :" + rows[0].date_depart + "\nla date d'arrivé :" + rows[0].date_arrive + "\nescale : " + rows[0].escale + "\nnombre de places que vous avez réservées: " + rows[0].nbrPlaceReserver , (err) => {
    // throws an error, you could also catch it here
    if (err) throw err;

    // success case, the file was saved
    console.log(' saved!');
});

         

        });



    });


});

// for action
router.post('/sign_in', function (req, res) {

    // check if logged 

    var username = req.body.username;
    var password = req.body.password;

    db.query('SELECT * FROM admin WHERE username = ? AND password = ?', [username, password], function (error, results, fields) {
        if (results.length > 0) {
            // ======== Display all Flights===========
            db.query("SELECT * FROM vols", (err, rows, fields) => {
                if (err) throw err;
                res.render('AdminVol', {
                    rows: rows
                })
            })

        } else {
            res.send('Incorrect Username and/or Password!');
        }




    })


});

// add new vol
router.post('/save', (req, res) => {

    let villeDepart = req.body.villeDepart;
    let villeArrive = req.body.villeArrive;
    let heurDepart = req.body.heurDepart;
    let heurArrive = req.body.heurArrive;
    let dateDepart = req.body.dateDepart;
    let dateArrive = req.body.dateArrive;
    let Escale = req.body.Escale;
    let nombrePlace = req.body.nombrePlace;


    let sql = "INSERT INTO vols (ville_depart, ville_arrive, heur_depart,heur_arrive,date_depart,date_arrive,escale,nombrePlace) VALUES ('" + villeDepart + "', '" + villeArrive + "', '" + heurDepart + "', '" + heurArrive + "','" + dateDepart + "', '" + dateArrive + "', '" + Escale + "', '" + nombrePlace + "')";
    db.query(sql, (err, results) => {
        if (err) throw err;

        db.query("SELECT * FROM vols", (err, rows, fields) => {
            if (err) throw err;
            res.render('AdminVol', {
                rows: rows
            })
        })
    });


})

//  Delete vol    
router.get('/delete/:IdVol', (req, res) => {



    const IdVol = req.params.IdVol;

    let sql = 'DELETE FROM vols WHERE IdVol = "' + IdVol + '"';
    db.query(sql, (err, result) => {
        if (err) throw err;

        res.redirect('/login');

    });
});

//======= EDIT Vol =========
router.get('/edit/:IdVol', (req, res) => {
    const id_vol = req.params.IdVol;
    let sql = 'Select * from vols where IdVol = "' + id_vol + '"';
    db.query(sql, (err, result) => {
        if (err) throw err;
        res.render('UpdateVol', {
            row: result[0],
            id: id_vol
        });
    });
});

router.post('/update', (req, res) => {

    const id = req.body.idVol_toEdit;

    let sql = "Update vols SET ville_depart='" + req.body.villeDepart + "', ville_arrive='" + req.body.villeArrive + "', heur_depart='" + req.body.heurDepart + "', heur_arrive='" + req.body.heurArrive + "',date_depart='" + req.body.dateDepart + "', date_arrive='" + req.body.dateArrive + "', escale='" + req.body.escale + "', nombrePlace='" + req.body.nombrePlace + "' where IdVol=" + id;
    db.query(sql, (err) => {
        if (err) throw err;
        db.query("SELECT * FROM vols", (err, rows, fields) => {
            if (err) throw err;
            res.render('AdminVol', {
                rows: rows
            })
        })
    });
});



module.exports = router;