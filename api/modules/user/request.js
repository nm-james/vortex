
var express = require('express');
const { NIL } = require('uuid');
var router = express.Router();
var query = require('../../database')

router.get('/id', async (req, res) => {
    const user_id = req.body.userID || '';

    // if the user id is simply non-existent, do not execute
    if (!user_id) {
        res.send('{}')
        return false
    }
        

    // find the data (steamid essentially) of the userid and send it
    const userDATA = await query('findUserByID', [user_id]);
    res.json(userDATA);
})

router.get('/steam', async(req, res) => {
    const steamID = req.headers.steamid || '';

    // if the user id is simply non-existent, do not execute
    if (steamID == '') {
        res.send('{}')
        return false
    }

    // find the data (steamid essentially) of the steamid and send it
    const userDATA = await query('findUserBySteamID', [steamID]);
    res.json(userDATA);
})




module.exports = router;
