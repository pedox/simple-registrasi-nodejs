express 			= require 'express'
http 				= require 'http'
path 				= require 'path'
expressValidator 	= require 'express-validator'

app = express()

expressValidator.validator.extend 'isUser', (str) ->
		regex = /^[a-zA-Z0-9_]{4,15}$/;
		if regex.test str
			return true
		else
			return false

app.set 'port', process.env.PORT || 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use expressValidator()
app.use express.methodOverride()
app.use app.router
app.use require('stylus').middleware(__dirname + '/public')
app.use express.static(path.join(__dirname, 'public'))

if 'development' == app.get 'env'
	app.use express.errorHandler()

require('./routes')(app)

require('./models/schema')()

http.createServer(app).listen app.get('port'), ->
	console.log 'Express server listening on port ' + app.get 'port'
