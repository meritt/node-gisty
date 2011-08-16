# Gisty

A Node.JS wrapper for [Gist's API v3](http://developer.github.com/v3/gists/).

<!-- [The announcement in Russian of this module in my blog.](http://nko.io/paGOx1) -->

How to use in JavaScript
------------------------

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

Or with CoffeeScript
--------------------

	Gisty = require('gisty').Gisty

	gist = new Gisty username: 'meritt'

	gist.fetch '1111422', (error, gist) ->
		throw new Error error if error
		console.log filename + "\n" + file.content + "\n\n" for filename, file of gist.files

Install with NPM
----------------

	npm install gisty

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