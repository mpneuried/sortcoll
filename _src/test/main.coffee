should = require('should')

sortcoll = require( "../." )

_moduleInst = null

testListA = [
	{ id: 1, name: "A" },
	{ id: 2, name: "B" },
	{ id: 3, name: "C" },
	{ id: 4, name: "A" }
]

testListB = [
	{ id: 13, name: "Foo", age: 42 },
	{ id: 1337, name: "Bar", age: 666 },
	{ id: 42, name: "Fizz", age: 23 },
	{ id: 23, name: "Bar", age: 23 },
	{ id: 666, name: "Buzz", age: 13 }
	{ id: 7, name: "Bar", age: 23 },
]

class Model
	constructor: ( data )->
		@data = {}
		for _k, _v of data
			@data[ _k ] = _v
		return
	get: ( key )->
		return @data[ key ]

largeList = require( "../testdata.json" )

testColl = []
for el in testListB
	testColl.push new Model( el )

test = ( list, exp, key="id" )->
	#console.log "RES",  list, exp
	for el, idx in list
		if not exp[idx]?
			break
		if el.get?
			el.get( key ).should.eql( exp[ idx ] )
		else
			el[ key ].should.eql( exp[ idx ] )
	return
		
describe "----- sortcoll TESTS -----", ->
	sorter = []
	before ( done )->
		fnGet = ( el, key )->
			return el.get( key )
		sorter.push sortcoll( [ "name", "id" ] )
		sorter.push sortcoll( [ "name", "id" ], false )
		sorter.push sortcoll( "id" )
		sorter.push sortcoll( [ "name", "id" ], true, fnGet )
		sorter.push sortcoll( [ "name", "id" ], { name: false, id: true } )
		sorter.push sortcoll( [ "age", "name", "id" ], { name: false, id: true, age: false } )
		sorter.push sortcoll( [ "age", "name", "id" ], { age: false, "?": true } )
		sorter.push sortcoll( [ "age", "name", "id" ], { age: false, "?": true  }, fnGet )
		done()
		return
	
	# Implement tests cases here
	it "by two keys", ->
		test(
			testListA.sort( sorter[0] )
			[ 1,4,2,3 ]
		)
		return
		
	# Implement tests cases here
	it "forward false", ->
		test(
			testListA.sort( sorter[1] )
			[ 3,2,4,1 ]
		)
		return
		
	it "simple key", ->
		test(
			testListA.sort( sorter[2] )
			[ 1,2,3,4 ]
		)
		return
		
	it "reuse sorter", ->
		test(
			testListB.sort( sorter[0] ),
			[ 7, 23, 1337, 666, 42, 13 ]
		)
		return
	
	it "large dataset", ->
		test(
			largeList.sort( sorter[0] ),
			[ "Abbott Trujillo", "Abigail Nunez", "Adams Holman", "Adela Hawkins" ],
			"name"
		)
		return
	
	it "sort with fnGet", ->
		test(
			testColl.sort( sorter[3] ),
			[ 7, 23, 1337, 666, 42, 13 ]
		)
		return
	
	it "sort with mixed forwards", ->
		test(
			testListB.sort( sorter[4] ),
			[ 13, 42, 666, 7, 23, 1337]
		)
		return
		
	it "sort with mixed forwards and 3 sort cols", ->
		test(
			testListB.sort( sorter[5] ),
			[ 1337, 13, 42, 7, 23, 666 ]
		)
		return
		
	it "sort with mixed fallback forward and 3 sort cols", ->
		test(
			testListB.sort( sorter[6] ),
			[ 1337, 13, 7, 23, 42, 666 ]
		)
		return
		
	it "sort with mixed fallback forward, 3 sort cols and the fnGet", ->
		test(
			testColl.sort( sorter[7] ),
			[ 1337, 13, 7, 23, 42, 666 ]
		)
		return
		
	return
