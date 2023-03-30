local take

-- Takes n from varargs
take = function(n, ...)
  local min = math.min(n, select('#', ...))
  if min == 0 then return end
  return (...), take(n - 1, select(2, ...))
end

return take
