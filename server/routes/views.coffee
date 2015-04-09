auth = require('../auth')
debug = require('debug')('routes:views')
module.exports = (app)->
	app.set 'view engine', 'jade'
	app.set 'views', './server/views'

	app.get '/error', (req, res)->
		res.render 'error'
	app.get '/', auth.ensureAuthenticated, (req, res)->
		debug 'res.user', req.user
		res.render 'index', {user: req.user}
