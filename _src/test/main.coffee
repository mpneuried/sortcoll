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
	{ id: 13, name: "Foo" },
	{ id: 1337, name: "Bar" },
	{ id: 42, name: "Fizz" },
	{ id: 23, name: "Bar" },
	{ id: 666, name: "Buzz" }
	{ id: 7, name: "Bar" },
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
	return
