debug = require('debug')('mongoose')

module.exports = (app)->
	mongoose = require( 'mongoose' )
	dbURI = 'mongodb://localhost/diorama'

	mongoose.connect(dbURI); 
	mongoose.connection.on 'connected', ()->
	  debug('Mongoose default connection open to ' + dbURI)

	mongoose.connection.on 'error', (err)->
	  debug('Mongoose default connection error: ' + err)
	
	mongoose.connection.on 'disconnected', ()->
	  debug('Mongoose default connection disconnected')
	
	process.on 'SIGINT', ()->
	  mongoose.connection.close ()->
	    debug('Mongoose default connection disconnected through app termination'); 
	    process.exit(0);

	require('../models')
