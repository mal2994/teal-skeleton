local object = require("object")

array = {}










setmetatable(array, { __index = object })





function array.new(data)
   return setmetatable(data, { __index = array })
end

function array.return_handler(data)
   return array.new(data)
end

array.unpack = table.unpack

function array.map(things, transformer)
   local tbl = {}
   for i, v in ipairs(things) do
      tbl[i] = transformer(v)
   end
   return array.return_handler(tbl)
end

function array.filter(things, predicate)
   local tbl = {}
   for _, v in ipairs(things) do
      if predicate(v) then
         table.insert(tbl, v)
      end
   end
   return array.return_handler(tbl)
end

function array.flatten(things)
   local tbl = {}
   for _, thing in ipairs(things) do
      if type(thing) == "table" then
         for _, subthing in ipairs(array.flatten(thing)) do
            table.insert(tbl, subthing)
         end
      else
         table.insert(tbl, thing)
      end
   end
   return array.return_handler(tbl)
end

function array.reduce(things, reducer)
   local out
   for _, thing in ipairs(things) do
      out = reducer(out, thing)
   end
   return out
end

function array.stringify(things)
   local tbl = array.flatten(things)
   local function to_string(thing)
      return thing and tostring(thing) or ""
   end

   return array.reduce(tbl, function(acc, i)
      if acc ~= nil then
         return to_string(acc) .. "," .. to_string(i)
      elseif i ~= nil then
         return to_string(i)
      end
   end)
end

function array.first(things)
   return things[1]
end

function array.range(start, finish, step)
   local tbl = {}
   step = step or 1
   for i = start, finish, step do
      table.insert(tbl, i)
   end
   return array.return_handler(tbl)
end
