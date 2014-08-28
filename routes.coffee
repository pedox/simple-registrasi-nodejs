Q = require 'q'
vars = require './hope/vars'
Users = require './models/users'
Hash = require './hope/hash'

module.exports = (app) ->

	app.get '/', (req, res) ->
		res.render 'home', title: vars.name, desc: vars.desc

	app.get '/register', (req, res) ->
		res.render 'register'
	app.post '/register', (req, res) ->
		req.assert('username', 'is required').notEmpty()
		req.assert('email', 'is required').notEmpty()
		req.assert('password', 'is required').notEmpty()
		req.assert('rePassword', 'is required').notEmpty()

		req.assert('email', 'harus email yang valid').isEmail()
		req.assert('username', 'minimal 4 dan maksimal 15 karakter').len(4, 15)
		req.assert('username', 'harus username yang valid').isUser()
		req.assert('rePassword', 'password tidak sama').equals(req.body.password)

		errors = req.validationErrors()


		Users.getByU req.body.username
		.then (result) ->
			Ierror = []
			if result
				Ierror.push {param:"username", msg:"Username Already Exits", value: req.body.username}
			Ierror
		.then (Ierror) ->
			result = Users.getByE req.body.email
			.then (result) ->
				if result
					Ierror.push {param:"email", msg:"Email Already Exits", value: req.body.email}
				Ierror

		.then (Ierror) ->

			if Ierror.length > 0
				try
					errors.length
					for err in Ierror
						errors.push err
				catch e
					errors = Ierror

			if errors
				res.json error: errors
			else
				Hash req.body.password, (err, hash) ->
					Users.add
						username: req.body.username
						email: req.body.email
						password: hash
						created_at: new Date
						updated_at: new Date
					.then (done) ->
						res.json success: 1
