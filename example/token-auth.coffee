###
  Retrieve all users gist with OAuth2 access token
###

Gisty = require('./../lib/gisty').Gisty

gist = new Gisty token: 'oauth access token', username: 'meritt'

gist.all (error, gists) ->
  throw new Error error if error
  console.log gists