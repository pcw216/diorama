express = require('express')
debug = require('debug')('github:org')
module.exports = org = (app, parent)->
	router = express.Router()	
	router.get '/', org.list
	router.get '/:pr', org.read
	parent.use('/org', router)

org.list = (req, res)->
	req.github().user.getOrgs {}, (err, response)->
		debug(err, response)
		res.json(response)

org.read = (req, res, next)-> next()
