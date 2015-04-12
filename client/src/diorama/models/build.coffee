angular.module('diorama.models.build', [])
.factory 'Build', (DS)->
	return DS.defineResource
		name: 'build'
		idAttribute: '_id'
