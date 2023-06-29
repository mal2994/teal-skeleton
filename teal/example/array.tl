local object = require("example.object")

global record array
	{any}
	
	unpack: function
	eq: function(a: {any}, b: {any}): boolean

	type transformation = function(thing: any): any
	type predication = function(thing: any): boolean
	type reduction = function(accumulation: any, thing: any): any
end

setmetatable(array, {__index = object})

local type transformation = array.transformation
local type predication = array.predication
local type reduction = array.reduction

function array.new(data: {any}): array
	return setmetatable(data, {__index = array})
end

function array.return_handler(data: {any}): array
	return array.new(data)
end

array.unpack = table.unpack

function array.map(things: {any}, transformer: transformation): array
	local tbl = {}
	for i, v in ipairs(things) do 
		tbl[i] = transformer(v)
	end
	return array.return_handler(tbl)
end

function array.filter(things: {any}, predicate: predication): array
	local tbl = {}
	for _, v in ipairs(things) do 
		if predicate(v) then
			table.insert(tbl, v)
		end
	end
	return array.return_handler(tbl)
end

function array.flatten(things: {any}): array
	local tbl = {}
	for _, thing in ipairs(things) do 
		if thing is {any} then 
			for _, subthing in ipairs(array.flatten(thing)) do 
				table.insert(tbl, subthing)
			end
		else
			table.insert(tbl, thing)
		end
	end
	return array.return_handler(tbl)
end

function array.reduce(things: {any}, reducer: reduction): any
	local out: any
	for _, thing in ipairs(things) do 
		out = reducer(out, thing)
	end
	return out 
end

function array.stringify(things: {any}): string 
	local tbl = array.flatten(things)	
	local function to_string(thing: any): string
		return thing and tostring(thing) or ""
	end
	
	return array.reduce(tbl, function(acc, i): string
		if acc ~= nil then
			return to_string(acc) .. "," .. to_string(i)
		elseif i ~= nil then 
			return to_string(i)
		end
	end) as string
end

function array.first(things: {any}): any
	return things[1]
end

function array.range(start: integer, finish: integer, step: integer|nil): array
	local tbl: {integer} = {}
	step = step or 1
	for i = start, finish, step do
		table.insert(tbl, i)
	end
	return array.return_handler(tbl)
end



