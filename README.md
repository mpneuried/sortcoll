sortcoll
============

[![Build Status](https://secure.travis-ci.org/mpneuried/sortcoll.png?branch=master)](http://travis-ci.org/mpneuried/sortcoll)
[![Build Status](https://david-dm.org/mpneuried/sortcoll.png)](https://david-dm.org/mpneuried/sortcoll)
[![NPM version](https://badge.fury.io/js/sortcoll.png)](http://badge.fury.io/js/sortcoll)

Simple helper to create a collection sort function for multiple keys.

[![NPM](https://nodei.co/npm/sortcoll.png?downloads=true&stars=true)](https://nodei.co/npm/sortcoll/)

## Install

```
npm install sortcoll
```

## Initialize

```js
var sortcoll = require( "sortcoll" )
```


## `sortcoll( keys, [forward=true], [fnGet] )``

**Usage** 

```js
var sortcoll = require( "sortcoll" )

var data = [  
  { id: 1, name: "Fritz" },
  { id: 2, name: "Müller" },
  { id: 3, name: "Meier" },
  { id: 4, name: "Fritz" }
];

var sortFunction = sortcoll( [ "name", "id" ], false );

var sorted = data.sort( sortFunction );
/*
[
    { id: 1, name: "Fritz" },
    { id: 4, name: "Fritz" },
    { id: 3, name: "Meier" },
    { id: 2, name: "Müller" }
]
*/
```

**Arguments:**

- **keys** : *( `String|String[]` required )* A simple key to sort by or a list of keys sorted in the given order. Similar to sql `ORDER BY name, id`
- **forward** : *( `Boolean|Object` optional: default = `true` )* Sort from a-z if `true`. Otherwise from `z-a`. You can set the direction for the sort keys separately by using an object. If you set a object key `?` this will be used for every not undefined key.
- **fnGet** : *( `Function` optional )* A optional function to get the sorting data from the element. Default is just `el[key]`


## Advanced example

**with `fnGet` and mixed forward**

Here's a small example to use the `fnGet` argument with e.g. backbone.

```js
var sortcoll = require( "sortcoll" )

var data = [  
	{ id: 13, name: "Foo", age: 42 },
	{ id: 1337, name: "Bar", age: 666 },
	{ id: 42, name: "Fizz", age: 23 },
	{ id: 23, name: "Bar", age: 23 },
	{ id: 666, name: "Buzz", age: 13 }
	{ id: 7, name: "Bar", age: 23 },
];

var fnGet = function( el, key ){
    return el.get( key )
};

var sortFunction = sortcoll( [ "name", "id" ], { age: false, "?": true }, fnGet );

myCollection = new Backbone.Collection( data, comparator: sortFunction )

var myCollection.toJSON();
/*
[
    { id: 1337, name: "Bar", age: 666 },
    { id: 13, name: "Foo", age: 42 },
    { id: 7, name: "Bar", age: 23 },
    { id: 23, name: "Bar", age: 23 },
    { id: 42, name: "Fizz", age: 23 },
    { id: 666, name: "Buzz", age: 13 }
]
*/
```

## Release History
|Version|Date|Description|
|:--:|:--:|:--|t 
|0.2.0|2016-03-22|added mixed forwarding|
|0.1.0|2016-03-22|Added the `fnGet` option.|
|0.0.1|2016-03-04|Initial commit|

[![NPM](https://nodei.co/npm-dl/sortcoll.png?months=6)](https://nodei.co/npm/sortcoll/)

> Initially Generated with [generator-mpnodemodule](https://github.com/mpneuried/generator-mpnodemodule)

## Other projects

|Name|Description|
|:--|:--|
|[**node-cache**](https://github.com/mpneuried/nsq-topics)|Simple and fast NodeJS internal caching. Node internal in memory cache like memcached|
|[**rsmq**](https://github.com/smrchy/rsmq)|A really simple message queue based on redis|
|[**redis-heartbeat**](https://github.com/mpneuried/redis-heartbeat)|Pulse a heartbeat to redis. This can be used to detach or attach servers to nginx or similar problems.|
|[**systemhealth**](https://github.com/mpneuried/systemhealth)|Node module to run simple custom checks for your machine or it's connections. It will use [redis-heartbeat](https://github.com/mpneuried/redis-heartbeat) to send the current state to redis.|
|[**rsmq-cli**](https://github.com/mpneuried/rsmq-cli)|a terminal client for rsmq|
|[**rest-rsmq**](https://github.com/smrchy/rest-rsmq)|REST interface for.|
|[**redis-sessions**](https://github.com/smrchy/redis-sessions)|An advanced session store for NodeJS and Redis|
|[**connect-redis-sessions**](https://github.com/mpneuried/connect-redis-sessions)|A connect or express middleware to simply use the [redis sessions](https://github.com/smrchy/redis-sessions). With [redis sessions](https://github.com/smrchy/redis-sessions) you can handle multiple sessions per user_id.|
|[**redis-notifications**](https://github.com/mpneuried/redis-notifications)|A redis based notification engine. It implements the rsmq-worker to safely create notifications and recurring reports.|
|[**nsq-logger**](https://github.com/mpneuried/nsq-logger)|Nsq service to read messages from all topics listed within a list of nsqlookupd services.|
|[**nsq-topics**](https://github.com/mpneuried/nsq-topics)|Nsq helper to poll a nsqlookupd service for all it's topics and mirror it locally.|
|[**nsq-nodes**](https://github.com/mpneuried/nsq-nodes)|Nsq helper to poll a nsqlookupd service for all it's nodes and mirror it locally.|
|[**nsq-watch**](https://github.com/mpneuried/nsq-watch)|Watch one or many topics for unprocessed messages.|
|[**hyperrequest**](https://github.com/mpneuried/hyperrequest)|A wrapper around [hyperquest](https://github.com/substack/hyperquest) to handle the results|
|[**task-queue-worker**](https://github.com/smrchy/task-queue-worker)|A powerful tool for background processing of tasks that are run by making standard http requests
|[**soyer**](https://github.com/mpneuried/soyer)|Soyer is small lib for server side use of Google Closure Templates with node.js.|
|[**grunt-soy-compile**](https://github.com/mpneuried/grunt-soy-compile)|Compile Goggle Closure Templates ( SOY ) templates including the handling of XLIFF language files.|
|[**backlunr**](https://github.com/mpneuried/backlunr)|A solution to bring Backbone Collections together with the browser fulltext search engine Lunr.js|
|[**domel**](https://github.com/mpneuried/domel)|A simple dom helper if you want to get rid of jQuery|
|[**obj-schema**](https://github.com/mpneuried/obj-schema)|Simple module to validate an object by a predefined schema|

## The MIT License (MIT)

Copyright © 2016 M. Peter, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
