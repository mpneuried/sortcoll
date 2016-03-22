# borrowed from https://github.com/juliangruber/isarray/blob/master/index.js ;-)
toString = {}.toString
isArray = Array.isArray || (arr)->
	return toString.call(arr) is '[object Array]'

_getKey = ( el, key )->
	return el[ key ]

module.exports = ( keys, forward=true, getKey=_getKey )->
	if not isArray(keys)
		keys = [ keys ]
		
	fnsort = ( forward, key, nextkeys )->
		if nextkeys?.length
			_k = nextkeys.splice(0,1)?[0]
			nextSort = fnsort( forward, _k, nextkeys ) if _k?
		return ( elA, elB )->
			_a = getKey( elA, key )
			_b = getKey( elB, key )
			if _a < _b
				return if forward then -1 else 1
			else if _a > _b
				return if forward then 1 else -1
			else if _a is _b
				if nextSort?
					return nextSort( elA, elB )
				else
					return 0
					
	return fnsort( forward, keys.splice(0,1), keys )
