debug = require('debug')('gruntfile')
_ = require('lodash')

module.exports = (grunt) ->
	grunt.loadNpmTasks 'grunt-develop'
	grunt.loadNpmTasks 'grunt-wiredep'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-stylus'
	grunt.loadNpmTasks 'grunt-html2js'
	
	grunt.registerTask 'client', ['wiredep', 'coffee', 'stylus', 'html2js']
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

		html2js:
			client:
				options:
					singleModule: false
					module: 'diorama.templates'
					base: 'client/src'
					jade:
						doctype: 'html'
					rename: (moduleName)-> moduleName.replace(/\.jade$/, '')
				src: ['client/src/**/*.jade']
				dest: 'client/public/templates.js'
 
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
					'client/public/index.css': ['client/src/**/*.styl']

		watch:
			options:
				nospawn: true
			client:
				files: [ 'client/src/**/*.*']
				tasks: ['client']
			server:
				files: [
					'server/**/*.coffee',
					'server/**/*.js'
				]
				tasks: ['develop']
