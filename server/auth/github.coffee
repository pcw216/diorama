passport = require('passport')
debug = require('debug')('auth')
GitHubStrategy = require('passport-github').Strategy
github = require('../lib/github')

scope = ['user', 'read:org']

module.exports = (app)->
	app.set('GITHUB_CLIENT_ID', '836d7163dce0b196b99a')
	app.set('GITHUB_CLIENT_SECRET', 'cf17b74549cba717c745d1039ec3d3afa830aa03')
	app.set('GITHUB_CALLBACK_URL', 'http://localhost:3000/auth/github/callback')
	
	config = 
		clientID: app.get('GITHUB_CLIENT_ID')
		clientSecret: app.get('GITHUB_CLIENT_SECRET')
		callbackURL: app.get('GITHUB_CALLBACK_URL')
	githubStrategy = new GitHubStrategy config, (accessToken, refreshToken, profile, done)->
		user = profile._json
		debug('github user', user)
		return done(null, {accessToken, refreshToken, profile:user})

	passport.use(githubStrategy);
	passport.serializeUser (user, done)-> done(null, user)
	passport.deserializeUser (user, done)-> done(null, user)
	app.use(passport.initialize());
	app.use(passport.session());

	app.get '/auth/github', passport.authenticate('github', {scope})

	app.get '/auth/github/callback', passport.authenticate('github', { failureRedirect: '/login' }), (req, res)->
		res.redirect('/')

  
module.exports.middleware = (req, res)->
	req.github = ()-> github(req.user)
