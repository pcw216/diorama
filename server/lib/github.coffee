_ = require('lodash')
GitHubApi = require("github")

module.exports = (user, options={})->
	github = new GitHubApi _.merge options,
		version: "3.0.0"
	github.authenticate
		type: "oauth"
		token: user.accessToken	
	return github
