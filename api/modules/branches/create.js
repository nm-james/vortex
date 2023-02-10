
var express = require('express');
var router = express.Router();
var query = require('../../database');
var uuid = require('uuid');

router.post('/create', async (req, res) => {
    const name = req.body.name || '';
    const newID = uuid.v4()

    await query('createNewBranch', [newID, name])

    res.redirect('/id');
})


module.exports = router;

