xhr = require 'request'

class Gisty
  api = 'https://api.github.com'

  constructor: (options = {}) ->
    @setOptions options

  setOptions: (@options) ->
    @options.username = @options.login if @options.login? and not @options.username?
    @

  fetch: (id, fn) ->
    throw new Error 'You should specify gist id for fetch information' unless id?
    @scheme = '/gists/' + id
    request @, fn

  comments: (id, fn) ->
    throw new Error 'You should specify gist id for fetch comments' unless id?
    @scheme = '/gists/' + id + '/comments'
    request @, fn

  all: (fn) ->
    @scheme = if @options.username? then '/users/' + @options.username + '/gists' else '/gists'
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

module.exports = Gisty