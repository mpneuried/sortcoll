# borrowed from https://github.com/juliangruber/isarray/blob/master/index.js ;-)
toString = {}.toString
isArray = Array.isArray || (arr)->
	return toString.call(arr) is '[object Array]'

module.exports = ( keys, forward=true )->
	if not isArray(keys)
		keys = [ keys ]
	fnsort = ( forward, key, nextkeys )->
		if nextkeys?.length
			_k = nextkeys.splice(0,1)?[0]
			nextSort = fnsort( forward, _k, nextkeys ) if _k?
		return ( elA, elB )->
			if elA[ key ] < elB[ key ]
				return if forward then -1 else 1
			else if elA[ key ] > elB[ key ]
				return if forward then 1 else -1
			else if elA[ key ] is elB[ key ]
				if nextSort?
					return nextSort( elA, elB )
				else
					return 0
	return fnsort( forward, keys.splice(0,1), keys )
