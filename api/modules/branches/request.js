
var express = require('express');
var router = express.Router();
var query = require('../../database')

router.get('/id', async (req, res) => {
    const branchid = req.headers.branchid || '';

    let branchdata = "[]"
    if (branchid == '') {
        branchdata = await query('getAllBranches', []);
    } else {
        branchdata = await query('findBranchByID', [branchid]);
    }

    res.json(branchdata);
})



module.exports = router;
