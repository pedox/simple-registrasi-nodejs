Q = require 'q'
vars = require './../hope/vars'
knex = require('knex')(vars.database)
table = 'users'

module.exports =

	getByU: (username) ->
		deferred = Q.defer()
		knex table
		.select()
		.where
			username: username
		.limit(1)
		.then (rows) ->
			if rows.length > 0
				deferred.resolve rows[0]
			else
				deferred.resolve false
		, (err) ->
			deferred.reject err

		deferred.promise

	getByE: (email) ->
		deferred = Q.defer()
		knex table
		.select()
		.where
			email: email
		.limit(1)
		.then (rows) ->
			if rows.length > 0
				deferred.resolve rows[0]
			else
				deferred.resolve false
		, (err) ->
			deferred.reject err

		deferred.promise

	add: (data) ->
		deferred = Q.defer()
		knex table
		.insert data
		.then (data) ->
			deferred.resolve data
		, (err) ->
			deferred.reject err

		deferred.promise
