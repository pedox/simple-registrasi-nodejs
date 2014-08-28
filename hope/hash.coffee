crypto = require 'crypto'
len = 128
iterations = 12000
salt = 'kata acak acakan'

module.exports = (pwd, fn) ->
	crypto.pbkdf2 pwd, salt, iterations, len, (err, hash) ->
		fn err, hash.toString 'base64'
		return
