

test("an example teal project", function(desc, it)
   desc("my testing", function()

      it("metatable used for subtyping.", function()
         local evens = {}



         setmetatable(evens, { __index = array })

         function evens.new(a)
            return setmetatable(a, { __index = evens })
         end

         function evens.div2(a)
            return a:map(function(thing) return thing / 2 end)
         end

         function evens.fromarray(a)
            local filtered = 
            a:filter(function(thing) return thing % 2 == 0 end)

            return evens.new(filtered)
         end

         return evens.
         fromarray(array.range(1, 10)):
         div2():
         eq({ 1, 2, 3, 4, 5 })
      end)

   end)

end)
