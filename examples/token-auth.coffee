###
  Retrieve all users gist with OAuth2 access_token
###

Gisty = require('./../lib/gisty').Gisty

gist = new Gisty token: 'OAuth2 access_token', username: 'meritt'

gist.all (error, gists) ->
  throw new Error error if error
  console.log gists