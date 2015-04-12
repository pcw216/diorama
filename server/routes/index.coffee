
module.exports = (app)->
	require('./api')(app)
	require('./views')(app)
	
