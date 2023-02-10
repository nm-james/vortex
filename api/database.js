const sql = require('mysql2/promise');
let connection = false;

// Predefine the commands dictionary so there is simply no commands
let commands = []

// Create a new prepared statement utilising a command string (by passing in the query and whether it is expecting mulitple rows)
async function createNewPreparedStatement( command, query, avoidSelectiveData ) {
    let queryStatement = await connection.prepare(query)
    commands[command] = async ( values ) => {
        // wait for the data after execution
        let data = await queryStatement.execute( values ) || [ [ {} ] ]

        // if the data has multiple rows, return the entire array
        let sortedData = data[0]
        if (avoidSelectiveData) {
            return sortedData || {}
        }

        // return data if only 1 row is expected
        return sortedData[0] || {}
    }
}

// initialize the schema of the database
function initializeDatabase( con ) {
    con.execute(`
        CREATE DATABASE IF NOT EXISTS vortex
    `)
}

// initialize the tables being used in the database
async function initializeTables( con ) {
    await con.execute('CREATE TABLE IF NOT EXISTS users(id MEDIUMTEXT, steamid BIGINT)')
    await con.execute('CREATE TABLE IF NOT EXISTS users_characters(id MEDIUMTEXT, userid MEDIUMTEXT, characterid MEDIUMTEXT)')
    await con.execute('CREATE TABLE IF NOT EXISTS characters(id MEDIUMTEXT, name TEXT, char_rank MEDIUMTEXT, char_reg MEDIUMTEXT)')
    await con.execute('CREATE TABLE IF NOT EXISTS loadouts(id MEDIUMTEXT, player_model TEXT, weapons JSON, clearance INT)')
    await con.execute('CREATE TABLE IF NOT EXISTS branches(id MEDIUMTEXT, name TEXT)')
    await con.execute('CREATE TABLE IF NOT EXISTS ranks(id MEDIUMTEXT, name TEXT, position INT, clearance TEXT)')

    await con.execute('CREATE TABLE IF NOT EXISTS regiments(id MEDIUMTEXT, name TEXT, color TEXT, view_model TEXT)')
    await con.execute('CREATE TABLE IF NOT EXISTS regiments_branches(id MEDIUMTEXT, regimentid MEDIUMTEXT, branchid MEDIUMTEXT)')
    await con.execute('CREATE TABLE IF NOT EXISTS regiments_factions(id MEDIUMTEXT, regimentid MEDIUMTEXT, factionid MEDIUMTEXT)')
    await con.execute('CREATE TABLE IF NOT EXISTS regiments_loadouts(id MEDIUMTEXT, regimentid MEDIUMTEXT, loadoutid MEDIUMTEXT)')

    await con.execute('CREATE TABLE IF NOT EXISTS rank_branches(id MEDIUMTEXT, branchid MEDIUMTEXT, rankid MEDIUMTEXT)')
}

// create prepared statements to be used as 'commands' when requested
async function initializeQueries() {
    await createNewPreparedStatement('findUserByID', 'SELECT * FROM users WHERE id = ?' )
    await createNewPreparedStatement('findUserBySteamID', 'SELECT * FROM users WHERE steamid = ?' )
    await createNewPreparedStatement('findBranchByID', 'SELECT * FROM branches WHERE id = ?' )
    await createNewPreparedStatement('findCharactersByUserID', `SELECT * FROM characters INNER JOIN users_characters ON characters.id = users_characters.characterid WHERE users_characters.userid = ?`, true )
    await createNewPreparedStatement('findRegimentByID', 'SELECT * FROM regiments WHERE id = ?' )
    await createNewPreparedStatement('findCharactersViaUserID', 'SELECT * FROM users_characters WHERE userid = ?' )
    await createNewPreparedStatement('findCharacterViaID', 'SELECT * FROM characters WHERE id = ?' )
    await createNewPreparedStatement('findBranchIDByRegimentID', 'SELECT branchid FROM regiments_branches WHERE regimentid = ?' )
    await createNewPreparedStatement('findRegimentsByBranchID', 'SELECT * FROM regiments INNER JOIN regiments_branches ON regiments.id = regiments_branches.regimentid WHERE regiments_branches.branchid = ?', true )
    await createNewPreparedStatement('findRegimentRanksByID', `SELECT * FROM ranks INNER JOIN rank_branches ON rank_branches.rankid = ranks.id WHERE rank_branches.branchid IN( SELECT regiments_branches.branchid FROM regiments_branches WHERE regimentid = ? )`, true )

    await createNewPreparedStatement('getAllRegiments', 'SELECT * FROM regiments', true )
    await createNewPreparedStatement('getRegimentLoadouts', 'SELECT loadouts.player_model AS model, loadouts.id AS id, loadouts.weapons AS weapons, loadouts.clearance AS clearance FROM loadouts LEFT JOIN regiments_loadouts ON regiments_loadouts.loadoutid = loadouts.id WHERE regiments_loadouts.regimentid = ?', true )
    await createNewPreparedStatement('getRegimentalData', 'SELECT regiments.name AS regiment_name, regiments.color AS regiment_color, regiments.view_model AS regiment_viewmodel, branches.id AS branch_id, branches.name AS branch_name FROM regiments INNER JOIN regiments_branches ON regiments_branches.regimentid = regiments.id INNER JOIN branches ON branches.id = regiments_branches.branchid WHERE regiments.id = ?' )
    await createNewPreparedStatement('getAllBranches', 'SELECT * FROM branches', true )

    await createNewPreparedStatement('createNewRegiment', 'INSERT INTO regiments(`id`, `name`, `color`, `view_model`) VALUES(?, ?, ?, ?)' )
    await createNewPreparedStatement('createNewLinkBetweenRegimentAndBranch', 'INSERT INTO regiments_branches(`id`, `regimentid`, `branchid`) VALUES(?, ?, ?)' )
    await createNewPreparedStatement('createNewUser', 'INSERT INTO users(`id`, `steamid`) VALUES(?, ?)' )
    await createNewPreparedStatement('createNewRegimentLoadout', 'INSERT INTO loadouts(id, player_model, weapons, clearance) VALUES(?, ?, ?, ?)' )
    await createNewPreparedStatement('createNewLinkBetweenRegimentAndLoadout', 'INSERT INTO regiments_loadouts(id, regimentid, loadoutid) VALUES(?, ?, ?)' )
    await createNewPreparedStatement('createNewBranch', 'INSERT INTO branches(`id`, `name`) VALUES(?, ?)' )
}


async function init() {
    // await connection and create schema as soon as connection has been established
    let con = await sql.createConnection({host:'localhost', user: 'root', password: 'NMJames2004', port: 3307, multipleStatements: true});
    await initializeDatabase( con )

    // redefine the database to the schema and initalize any tables and queries
    connection = await sql.createConnection({host:'localhost', user: 'root', password: 'NMJames2004', port: 3307, database: "vortex", multipleStatements: true});
    await initializeTables( connection )
    await initializeQueries()
}

// execute the command and check whether it exists. Pass in the data in the format of the array (which correlates to the ? in the prepared queries)
async function executeCommand( commandLine, data ) {
    if (!commands[commandLine]) return {}
    return commands[commandLine]( data )
}

// start initializing the server
init()

module.exports = executeCommand;
