local take = require'take'

print'Eyeballs test, should be 1, 2, 3, 4, 5 do'
io.write'  '
print(take(10, 1, 2, 3, 4, 5))
print'end'

-- Generate test tables
local tests = {}
do
  local tests_here = {
    {4, {1, 2, 3, 4}, {1, 2, 3, 4}},
    {10, {1, 2, 3, 4}, {1, 2, 3, 4}},
    {0, {1, 2, 3, 4}, {}},
    {1, {1, 2, 3, 4}, {1}},
    {5, {}, {}},
    {0, {}, {}},
  }
  for i, v in ipairs(tests_here) do
    tests[i] = {n = v[1], varargs = v[2], result = v[3]}
  end
end

-- Compares two arrays for equality
local cmp = function(t1, t2)
  for i, v in ipairs(t1) do if t2[i] ~= v then return false end end
  for i, v in ipairs(t2) do if t1[i] ~= v then return false end end
  return true
end

-- Perform tests
for _, test in pairs(tests) do
  io.write'test'
  local result = table.pack(take(test.n, table.unpack(test.varargs)))
  assert(cmp(result, test.result))
  print' = true'
end
