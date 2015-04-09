
module.exports = (app)->
	require('./views')(app)
	require('./github')(app)
