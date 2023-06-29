global test: function(title: string, f: function)
--global desc: function(msg: string, f: function)
--global it: function(msg: string, f: function)

test("an example teal project", function(desc: function, it: function)
	desc("my testing", function(): boolean...
	
		it("metatable used for subtyping.", function(): boolean...
			local record evens 
				{any}
				map: function({any}, array.transformation): array
			end
			setmetatable(evens, {__index = array})
			
			function evens.new(a: {any}): evens
				return setmetatable(a, {__index = evens})
			end

			function evens.div2(a: evens): array
				return a
					:map(function(thing: integer): any return thing / 2 end)
			end
			
			function evens.fromarray(a: array): evens
			 	local filtered = 
					a:filter(function(thing: integer): boolean return thing % 2 == 0 end) 
	
				return evens
					.new(filtered)
			end

			return evens
				.fromarray(array.range(1, 10))
				:div2()
				:eq({1,2,3,4,5})
		end)

	end)
	
end)
--