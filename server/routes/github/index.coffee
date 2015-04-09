express = require('express')

auth = require('../../auth')
module.exports = github = (app)->
	router = express.Router()
	router.all('*', auth.ensureAuthenticated)	
	require('./org')(router)
	app.use('/github', router)
	
