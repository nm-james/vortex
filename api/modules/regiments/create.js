
var express = require('express');
var router = express.Router();
var query = require('../../database');
var uuid = require('uuid');

router.post('/create', async (req, res) => {
    const name = req.body.name
    const branchid = req.body.branch
    const color = req.body.color
    const view_model = req.body.view_model


    const newRegimentID = uuid.v4()
    const newRegimentAndBranchID = uuid.v4()

    if (name == "" || branchid == "") {
        return false
    }

    await query('createNewRegiment', [newRegimentID, name, color, view_model])
    await query('createNewLinkBetweenRegimentAndBranch', [newRegimentAndBranchID, newRegimentID, branchid])

    for (let i = 1; i < 8; i++) {
        let newLoadoutID = uuid.v4();
        query( 'createNewRegimentLoadout', [newLoadoutID, 'models/player/soldier_stripped.mdl', '[]', i] )
        query( 'createNewLinkBetweenRegimentAndLoadout', [uuid.v4(), newRegimentID, newLoadoutID] )
    }

    res.json('[]')
})

module.exports = router;

