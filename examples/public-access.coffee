###
  Retrieve public gist
###

Gisty = require('./../lib/gisty')

gist = new Gisty username: 'meritt'

gist.fetch '1111422', (error, gist) ->
  throw new Error error if error
  console.log "#{filename}\n--------------\n\n#{file.content}\n\n" for filename, file of gist.files