local object = {}

function object.new(data)
   return setmetatable(data, { __index = object })
end

function object.return_handler(data)
   return object.new(data)
end

function object.result(data)
   return setmetatable(data, {})
end

local table_eq

table_eq = function(a, b)
   for i, _ in pairs(a) do
      if type(a[i]) == "table" and type(b[i]) == "table" then
         if table_eq(a[i], b[i]) ~= true then
            return false
         end
      else
         return a == b
      end
   end
   return true
end

function object.eq(a, b)
   if type(a) == "table" and
      type(b) == "table" then
      return table_eq(a, b) and
      table_eq(b, a)
   else
      return a == b
   end
end

return object
