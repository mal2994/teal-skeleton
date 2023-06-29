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

   if not (type(a) == "table") and not (type(b) == "table") then
      return a == b
   end

   if type(a) == "table" and type(b) == "table" then
      for i, _ in pairs(a) do
         if object.eq(a[i], b[i]) ~= true then
            return false
         end
      end
   end

   if type(a) == "table" and type(b) == "table" then
      for i, _ in pairs(b) do
         if object.eq(a[i], b[i]) ~= true then
            return false
         end
      end
   end

   return true
end

return object
