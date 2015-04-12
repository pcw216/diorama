debug = require('debug')('app:initialization')
express = require('express')
path = require('path')
bodyParser = require('body-parser')
session = require('express-session')

mongoose = require('./lib/mongoose')

app = express()
mongoose(app)
app.use(require('cookie-parser')())

app.use(bodyParser.urlencoded({extended: true}))
app.use(bodyParser.json())

app.use(session({ secret: 'daguerreotype', saveUninitialized: true, resave: true }))
bowerComponents = path.resolve(__dirname, './../bower_components')
debug('bower_components path', bowerComponents)
app.use('/bower_components', express.static(bowerComponents))
publicAssets = path.resolve(__dirname, './../client/public')
debug('public assets path', publicAssets)
app.use('/public', express.static(publicAssets))

app.set('json spaces', 2)
require('./auth')(app)
require('./routes')(app)


module.exports = app
