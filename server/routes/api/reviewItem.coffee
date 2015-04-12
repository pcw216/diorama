express = require('express')
debug = require('debug')('api:reviewItem')
mongoose = require('mongoose')
Build = mongoose.model('Build')

module.exports = reviewItem = (app, parent)->
	router = express.Router()	
	router.get '/', reviewItem.list
	router.get '/:id', reviewItem.read
	router.put '/:id', reviewItem.update
	router.post '/', reviewItem.create
	parent.use('/reviewItem', router)

reviewItem.list = (req, res, next)->
	Build.find (err, results)-> 
		if err? then return next(err)
		res.json(results)
	
reviewItem.create = (req, res, next)->
	req.body.status ?= 'pending'
	Build.create req.body, (err, result)->
		if err? then return next(err)
		res.json(result)

reviewItem.update = (req, res, next)->
	Build.findOneAndUpdate {_id: req.params.id}, req.body, (err, result)->
		if err? then return next(err)
		res.json(result)

reviewItem.read = (req, res, next)-> 
	Build.findById req.params.id, (err, result)->
		if err? then return next(err)
		res.json(result)
