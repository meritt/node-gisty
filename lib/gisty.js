(function() {
  var Gisty, xhr;
  xhr = require('request');
  Gisty = (function() {
    var api, request;
    api = 'https://api.github.com';
    function Gisty(login, password) {
      this.login = login;
      this.password = password;
      this.username = this.login;
    }
    Gisty.prototype.setUsername = function(username) {
      this.username = username;
      return this;
    };
    Gisty.prototype.fetch = function(id, fn) {
      this.scheme = '/gists/' + id;
      return request(this, fn);
    };
    Gisty.prototype.comments = function(id, fn) {
      this.scheme = '/gists/' + id + '/comments';
      return request(this, fn);
    };
    Gisty.prototype.all = function(fn) {
      this.scheme = '/users/' + this.username + '/gists';
      return request(this, fn);
    };
    Gisty.prototype.public = function(fn) {
      this.scheme = '/gists/public';
      return request(this, fn);
    };
    Gisty.prototype.starred = function(fn) {
      this.scheme = '/gists/starred';
      return request(this, fn);
    };
    request = function(self, fn) {
      var options;
      if (fn == null) {
        fn = function() {};
      }
      options = {
        url: api + self.scheme,
        headers: {
          Authorization: 'Basic ' + new Buffer(self.login + ':' + self.password).toString('base64')
        }
      };
      return xhr(options, function(error, request, body) {
        var limit, _ref;
        body = JSON.parse(body);
        if ((_ref = request.statusCode) !== 200 && _ref !== 201 && _ref !== 204) {
          error = body;
        }
        limit = request.headers != null ? parseInt(request.headers['x-ratelimit-remaining']) > 0 : true;
        if (!error && !limit) {
          error = {
            message: 'Your limit is over'
          };
        }
        return fn.call(self, error, body);
      });
    };
    return Gisty;
  })();
  exports.Gisty = Gisty;
}).call(this);
