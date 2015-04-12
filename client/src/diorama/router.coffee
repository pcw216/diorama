angular.module('diorama.router', [
	'ui.router'
	'diorama.templates'
	'diorama.states'
	'diorama.models'
	'ncy-angular-breadcrumb'
])
.config ($stateProvider, $urlRouterProvider, $locationProvider)->
	$locationProvider.html5Mode(true)
	$urlRouterProvider.otherwise("/build/");
	$stateProvider	
		.state 'build',
			url: '/build'
			abstract: true
			template: '<div class="build" ui-view=""/>'

		.state 'build.list',
			url: '/'
			templateUrl: 'diorama/states/build/list'
			controller: 'BuildListController as builds'
			ncyBreadcrumb:
				label: 'Builds'

		.state 'build.create',
			url: '/create'
			templateUrl: 'diorama/states/build/create'
			controller: 'BuildEditController as build'
			ncyBreadcrumb:
				parent: 'build.list'
			resolve:
				$record: ()-> null
		
		.state 'build.single',
			abstract: true
			url: '/:buildId'
			template: '<div ui-view/>'
			resolve:
				$record: (Build, $stateParams)-> Build.find($stateParams.buildId)

		.state 'build.review',
			parent: 'build.single'
			url: '/'
			templateUrl: 'diorama/states/build/review'
			controller: 'BuildReviewController as build'
			ncyBreadcrumb:
				parent: 'build.list'
				label: 'Review'

		.state 'build.edit',
			parent: 'build.single'
			url: '/edit'
			templateUrl: 'diorama/states/build/edit'
			controller: 'BuildEditController as build'
			ncyBreadcrumb:
				parent: 'build.list'
				label: 'Edit'

.run ($rootScope, $state, $templateCache)->
	$rootScope.app ?= {}
	$rootScope.app.$state = $state
	window.$state = $state
	window.$templateCache = $templateCache

