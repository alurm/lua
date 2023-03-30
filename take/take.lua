local take

-- Takes n from varargs
take = function(n, ...)
  local min = math.min(n, select('#', ...))
  if min == 0 then return end

--[[
  -- Naive implementation, causes stack overflow on large inputs
  -- Perhaps interpreter could help
  -- Tail recursion modulo cons?
  -- en.wikipedia.org/wiki/Tail_call#Tail_recursion_modulo_cons
  local head = (...)
  return head, take(n - 1, select(2, ...))
--]]

----[[
  local output = {}
  for i, v in ipairs(table.pack(...)) do
    output[i] = v
    if i == n then break end
  end
  return table.unpack(output)
--]]
end

return take
