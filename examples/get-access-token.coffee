express   = require 'express'
everyauth = require 'everyauth'

everyauth.debug = true;

options =
  host:   'http://localhost:3000' # change this
  id:     '-- client id --'       # change this
  secret: '-- client secret --'   # change this

current = token = null

everyauth.github.myHostname   options.host
everyauth.github.redirectPath '/'
everyauth.github.apiHost      'https://api.github.com'
everyauth.github.appId        options.id
everyauth.github.appSecret    options.secret
everyauth.github.scope        'gist'

everyauth.github.findOrCreateUser (session, accessToken, accessTokenExtra, user) ->
  [token, current] = [accessToken, user]

everyauth.github.fetchOAuthUser (accessToken) ->
  p = @Promise()
  @oauth.get @apiHost() + '/user', accessToken, (error, data) ->
    return p.fail error if error
    oauthUser = JSON.parse data
    p.fulfill oauthUser
  p

app = express.createServer()

app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session secret: 'node-gisty'
app.use everyauth.middleware()

app.set 'views', __dirname + '/views'
app.set 'view engine', 'ejs'
app.set 'view options', layout: false

app.get '/', (request, response) ->
  if not request.loggedIn
    response.render 'login'
  else
    response.render 'result'
      login: current.login
      name:  current.name
      token: token

everyauth.helpExpress app

app.listen 3000
console.log 'Go to ' + options.host