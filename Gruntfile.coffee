debug = require('debug')('gruntfile')
_ = require('lodash')

module.exports = (grunt) ->
	grunt.loadNpmTasks 'grunt-develop'
	grunt.loadNpmTasks 'grunt-wiredep'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-stylus'
	
	grunt.registerTask 'client', ['wiredep', 'coffee', 'stylus']
	grunt.registerTask 'default', ['wiredep', 'client', 'develop', 'watch']

	grunt.initConfig
		develop:
			server:
				file: 'bin/diorama-server'

		wiredep:
			task:
				src: [
					'server/views/common/scripts.jade'
					'server/views/common/styles.jade'
				]
				options:
					ignorePath: '../../..'
					onPathInjected: _.partial(debug, 'wiredep file')
		coffee:
			client:
				options:
					sourceMap: true
					join: true
				files: 
					'client/public/index.js': ['client/src/**/*.coffee']

		stylus:
			compile:
				options:
					use: [
						require('nib')
					]
				files:
					'client/public/index.css': ['client/styles/**/*.styl']

		watch:
			options:
				nospawn: true
			client:
				files: [ 'client/src/**/*.coffee', 'client/styles/**/*.styl']
				tasks: ['client']
			server:
				files: [
					'server/**/*.coffee',
					'server/**/*.js'
				]
				tasks: ['develop']
