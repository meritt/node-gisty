# Gisty

A Node.JS wrapper for [GitHub gist API v3](http://developer.github.com/v3/gists/).

<!-- [The announcement in Russian of this module in my blog.](http://nko.io/paGOx1) -->

How to use with JavaScript
--------------------------

```javascript
var Gisty = require('gisty').Gisty;

var gist = new Gisty({username: meritt});

gist.fetch('1111422', function(error, gist) {
	if (error) {
		throw new Error(error);
	}
	for (filename in gist.files) {
		console.log(filename + "\n" + gist.files[filename].content + "\n\n");
	}
});
```

Or with CoffeeScript
--------------------

```coffeescript
Gisty = require('gisty').Gisty

gist = new Gisty username: 'meritt'

gist.fetch '1111422', (error, gist) ->
	throw new Error error if error
	console.log filename + "\n" + file.content + "\n\n" for filename, file of gist.files
```

[See other examples](http://github.com/meritt/node-gisty/tree/master/examples)

Install with NPM
----------------

```
npm install gisty
```

How to retrieve GitHub OAuth2 access_token
------------------------------------------

Grab latest source code and install all dev dependencies

```
npm link
```

Change your host, client id, client secret in [examples/get-access-token.coffee](http://github.com/meritt/node-gisty/blob/master/examples/get-access-token.coffee) and after that run [examples/get-access-token.coffee](http://github.com/meritt/node-gisty/blob/master/examples/get-access-token.coffee)

```
coffee examples/get-access-token.coffee
```

API
---

* fetch (*gist id*, *callback*)
* comments (*gist id*, *callback*)
* all (*callback*)
* public (*callback*)
* starred (*callback*)

Author
------

* Alexey Simonenko, dwarfman@gmail.com