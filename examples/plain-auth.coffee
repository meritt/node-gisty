###
  Retrieve starred gist with plain authenticate
###

Gisty = require('./../lib/gisty')

gist = new Gisty login: 'login', password: 'password'

gist.starred (error, gists) ->
  throw new Error error if error
  console.log gists