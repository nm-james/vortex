
var express = require('express');
var router = express.Router();
var query = require('../../database')

router.get('/id', async (req, res) => {
    const regID = req.headers.regid || ''
    let regData = {}
    if (regID == '') {
        regData = await query('getAllRegiments', []);
    } else {
        regData = await query('getRegimentalData', [regID]);
    }
    const regDataJSON = JSON.stringify(regData)
    
    res.send(regDataJSON);
})

router.get('/loadouts', async (req, res) => {
    const regID = req.headers.regid || ''
    let regData = await query('getRegimentLoadouts', [regID])
    const regDataJSON = JSON.stringify(regData)
    res.send(regDataJSON);
})

module.exports = router;
