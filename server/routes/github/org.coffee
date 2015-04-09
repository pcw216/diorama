express = require('express')
debug = require('debug')('github:org')
module.exports = org = (app)->
	router = express.Router()	
	router.get '/', org.list
	router.get '/:pr', org.read
	app.use('/org', router)

org.list = (req, res)->
	req.github().user.getOrgs {}, (err, response)->
		debug(err, response)
		res.json(response)

org.read = (req, res, next)-> next()
