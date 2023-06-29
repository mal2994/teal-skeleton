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

function object.eq(a, b)
   for i, _ in pairs(a) do
      if type(a[i]) == "table" and type(b[i]) == "table" then
         if object.eq(a[i], b[i]) ~= true then
            return false
         end
      elseif a[i] ~= b[i] then
         return false
      end
   end

   for i, _ in pairs(b) do
      if type(a[i]) == "table" and type(b[i]) == "table" then
         if object.eq(a[i], b[i]) ~= true then
            return false
         end
      elseif a[i] ~= b[i] then
         return false
      end
   end

   return true
end

return object
