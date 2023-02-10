var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.use( bodyParser.json() );
app.use( express.urlencoded( {extended: false} ) );

app.use('/users', require('./modules/user/request'))
app.use('/users', require('./modules/user/create'))
app.use('/regiments', require('./modules/regiments/request'))
app.use('/regiments', require('./modules/regiments/create'))
app.use('/branches', require('./modules/branches/request'))
app.use('/branches', require('./modules/branches/create'))



app.listen(3690);

