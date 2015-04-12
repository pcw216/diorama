express = require('express')
auth = require('../../auth')
	
module.exports = (app)->
	router = express.Router()
	router.all('*', auth.ensureAuthenticated)

	require('./github')(app, router)
	require('./build')(app, router)

	app.use('/api', router)
