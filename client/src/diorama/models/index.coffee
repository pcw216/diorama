angular.module('diorama.models', [
	'js-data'
	'diorama.models.build'
])
.config (DSProvider)->
    DSProvider.defaults.basePath = '/api'
