angular.module('diorama.states.build.controllers', [
	'diorama.models.build'
	'ui.router'
])
.controller 'BuildReviewController', class BuildReviewController
	constructor: ($state, @$record, Build)->
		@Build = Build
		@$state = $state
		@record(@$record)

	record: (record)=>
		fields = ['_id', 'name', 'description', 'url', 'status']
		if record?
			_.merge(@, _.pick(record, fields))
			# TODO get images
		else
			return _.pick(@, fields)
	
	setStatus: (status)->
		data = @record()
		@Build.update(data._id, data)

	edit: ()->
		@$state.go('^.edit')

.controller 'BuildListController', class BuildListController

	constructor: (@$scope, Build, $state)->
		@Build = Build
		@$state = $state
		@$scope.$watch @lastModifiedBuild, ()=> @records = @Build.filter({})
		@Build.findAll()

	lastModifiedBuild: ()=> @Build.lastModified()

	create: ()=> @$state.go('^.create')	

.controller 'BuildListItemController', class BuildListItemController

	constructor: (@$scope, $state)->
		@$state = $state
		@$scope.$watch _.partial(@get, 'name'), _.partial(@set, 'name')
		@$scope.$watch _.partial(@get, 'status'), @_setStatus

	init: (@record)=>
	get: (property)=> 
		if property
			return @record[property]
		return @record	
	set: (property, value)=> @[property] = value

	_setStatus: (value)=>
		@set('status', value)
		@statusLabelClass = switch value
			when 'pending' then 'label-warning'
			else 'label-success'

	review: ()=> @$state.go('^.review', {buildId: @get('_id')})

.controller 'BuildEditController', class BuildEditController

	constructor: (@$scope, $state, Build, @$record)->
		@Build = Build
		@$state = $state
		@record(@$record)
	
	init: (@form)=>
		
	record: (record)=>
		fields = ['_id', 'name', 'description', 'url']
		if record?
			_.merge(@, _.pick(record, fields))
		else
			return _.pick(@, fields)

	submit: ()=>
		data = @record()
		if @$record
			# TODO not refreshing record
			promise = @Build.update(data._id, data)
		else 
			promise = @Build.create(data)
		promise.then ()=>
			@$state.go('^.list')

	cancel: ()=> @$state.go('^.list')
