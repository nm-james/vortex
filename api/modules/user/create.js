
var express = require('express');
var router = express.Router();
var query = require('../../database');
var uuid = require('uuid');

// create a new method of making a new user
router.post('/create', async (req, res) => {
    // check whether steamid has been properly passed
    const steamid = req.body.steamID
    if (!steamid)
        return false

    // new id, what do you expect
    const newID = uuid.v4()

    // insert new user utilising the newid and its steamid
    await query('createNewUser', [newID, steamid])
    const apiID = await query('findUserBySteamID', [steamid])
    res.send( apiID )
})



module.exports = router;

