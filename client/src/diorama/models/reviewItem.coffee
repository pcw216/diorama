angular.module('diorama.models.reviewItem', [])
.factory 'ReviewItem', (DS)->
	return DS.defineResource
		name: 'reviewItem'
		idAttribute: '_id'
