###
  node-gisty 0.0.1
  (c) 2011 Alexey Simonenko, Serenity LLC.
  For all details and documentation:
  http://github.com/meritt/node-gisty
###

xhr = require 'request'

class Gisty
  api = 'https://api.github.com'

  constructor: (options = {}) ->
    @setOptions options

  setOptions: (@options) ->
    @options.username = @options.login if @options.login? and not @options.username?
    @

  fetch: (id, fn) ->
    @scheme = '/gists/' + id
    request @, fn

  comments: (id, fn) ->
    @scheme = '/gists/' + id + '/comments'
    request @, fn

  all: (fn) ->
    @scheme = '/users/' + @username + '/gists'
    request @, fn

  public: (fn) ->
    @scheme = '/gists/public'
    request @, fn

  starred: (fn) ->
    @scheme = '/gists/starred'
    request @, fn

  request = (self, fn = ->) ->
    options = url: api + self.scheme

    if self.options.token?
      options['headers'] = Authorization: "token #{self.options.token}"
    else if self.options.login? and self.options.password?
      options['headers'] = Authorization: "Basic " + new Buffer(self.options.login + ':' + self.options.password).toString('base64')

    xhr options, (error, request, body) ->
      body  = JSON.parse body
      error = body if request.statusCode not in [200, 201, 204]

      limit = if request.headers? then parseInt(request.headers['x-ratelimit-remaining']) > 0 else true
      error = {message: 'Your limit is over'} if not error and not limit

      fn.call self, error, body

exports.Gisty = Gisty