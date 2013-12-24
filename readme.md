# gisty

[![NPM version](https://badge.fury.io/js/gisty.png)](http://badge.fury.io/js/gisty) [![Dependency Status](https://david-dm.org/meritt/node-gisty.png)](https://david-dm.org/meritt/node-gisty)

A node.js wrapper for the GitHub [Gists API v3](http://developer.github.com/v3/gists/).

## Installation

```
$ npm install gisty
```

## Examples

```js
var Gisty = require('gisty');

var gist = new Gisty({
  username: 'meritt'
});

gist.fetch('1111422', function(error, gist) {
  if (error) {
    throw new Error(error);
  }

  for (filename in gist.files) {
    console.log(filename + "\n" + gist.files[filename].content + "\n\n");
  }
});
```

```coffeescript
Gisty = require 'gisty'

gist = new Gisty username: 'meritt'

gist.fetch '1111422', (error, gist) ->
  throw new Error error if error
  console.log "#{filename}\n#{file.content}\n\n" for filename, file of gist.files
```

[See other examples](http://github.com/meritt/node-gisty/tree/master/examples)

## How to retrieve github OAuth2 access_token

Grab latest source code and install all dev dependencies

```
$ npm link
```

Change your host, client id, client secret in [examples/get-access-token.coffee](http://github.com/meritt/node-gisty/blob/master/examples/get-access-token.coffee) and after that run [examples/get-access-token.coffee](http://github.com/meritt/node-gisty/blob/master/examples/get-access-token.coffee)

```
$ coffee examples/get-access-token.coffee
```

## API

* fetch (gist_id, callback)
* comments (gist_id, callback)
* all (callback)
* public (callback)
* starred (callback)

## Author

* [Alexey Simonenko](mailto:alexey@simonenko.su), [simonenko.su](http://simonenko.su)

## License

The MIT License, see the included `license.md` file.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/meritt/node-gisty/trend.png)](https://bitdeli.com/free "Bitdeli Badge")