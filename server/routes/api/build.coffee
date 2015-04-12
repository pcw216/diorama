express = require('express')
debug = require('debug')('api:build')
mongoose = require('mongoose')
Build = mongoose.model('Build')

module.exports = build = (app, parent)->
	router = express.Router()	
	router.get '/', build.list
	router.get '/:id', build.read
	router.put '/:id', build.update
	router.post '/', build.create
	parent.use('/build', router)

build.list = (req, res, next)->
	Build.find (err, results)-> 
		if err? then return next(err)
		res.json(results)
	
build.create = (req, res, next)->
	req.body.status ?= 'pending'
	Build.create req.body, (err, result)->
		if err? then return next(err)
		res.json(result)

build.update = (req, res, next)->
	Build.findOneAndUpdate {_id: req.params.id}, req.body, (err, result)->
		if err? then return next(err)
		res.json(result)

build.read = (req, res, next)-> 
	Build.findById req.params.id, (err, result)->
		if err? then return next(err)
		res.json(result)
