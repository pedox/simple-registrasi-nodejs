vars = require './../hope/vars'
knex = require('knex')(vars.database)

module.exports = () ->
	
	knex.schema
	.hasTable 'users'
	.then (exists) ->
		if !exists
			knex.schema.createTable 'users', (t) ->
				t.increments()
				t.string('username')
				t.string('email')
				t.string('password')
				t.timestamps()

				console.log 'tabel users di tambah ke database'