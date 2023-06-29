local record object end

function object.new(data: table): object
	return setmetatable(data, {__index = object}) as object
end

function object.return_handler(data: table): object
	return object.new(data) 
end

function object.result(data: object): table
	return setmetatable(data, {}) as table
end

local table_eq: function(table, table): boolean

table_eq = function(a: table, b: table): boolean
	for i, _ in pairs(a) do 
		if type(a[i]) == "table" and type(b[i]) == "table" then
			if table_eq(a[i] as table, b[i] as table) ~= true then
				return false 
			end
		else
			return a == b 
		end
	end
	return true
end

function object.eq(a: any, b: any): boolean
	if  a is table 
	and b is table then
		return table_eq(a as table, b as table) 
		   and table_eq(b as table, a as table)
	else
		return a == b
	end
end

return object
