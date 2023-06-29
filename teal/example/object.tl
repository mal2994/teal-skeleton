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

function object.eq(a: any, b: any): boolean                                                          
 
	if not a is table and not b is table then 
		return a == b                                                                                      
	end 

	if a is table and b is table then
		for i, _ in pairs(a as table) do                                                                          
			if object.eq(a[i], b[i]) ~= true then
				return false
			end
		end                                                                                              
	end

	if a is table and b is table then
		for i, _ in pairs(b as table) do                                                                          
			if object.eq(a[i], b[i]) ~= true then
				return false
			end
		end
	end
																										
	return true
end            

return object
