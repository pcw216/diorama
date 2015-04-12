express = require('express')

module.exports = github = (app, parent=app)->
	router = express.Router()
	require('./org')(app, router)
	parent.use('/github', router)
	
