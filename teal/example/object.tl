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

function object.eq(a: table, b: table): boolean
	for i, _ in pairs(a) do 
		if type(a[i]) == "table" and type(b[i]) == "table" then
			if object.eq(a[i] as table, b[i] as table) ~= true then
				return false
			end
		elseif a[i] ~= b[i] then
			return false
		end
	end

	for i, _ in pairs(b) do 
		if type(a[i]) == "table" and type(b[i]) == "table" then
			if object.eq(a[i] as table, b[i] as table) ~= true then
				return false
			end
		elseif a[i] ~= b[i] then
			return false
		end
	end

	return true
end

return object
