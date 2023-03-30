local take = require'take'

-- Generate a table
local function gen(size)
  local t = {}
  for i = 1, size do
    t[i] = i
  end
  return t
end

local function gen_test(size)
  local t = gen(size)
  return {size, t, t}
end

local function gen_tests(opts)
  local tests = {}
  local tests_array = {
    {4, {1, 2, 3, 4}, {1, 2, 3, 4}},
    {10, {1, 2, 3, 4}, {1, 2, 3, 4}},
    {0, {1, 2, 3, 4}, {}},
    {1, {1, 2, 3, 4}, {1}},
    {5, {}, {}},
    {0, {}, {}},
  }

  if opts.sizes then
    for _, size in ipairs(opts.sizes) do
      table.insert(tests_array, gen_test(size))
    end
  end

  -- Convert array to table
  for i, v in ipairs(tests_array) do
    tests[i] = {n = v[1], varargs = v[2], result = v[3]}
  end

  return tests
end

-- Compares two arrays for equality
local cmp = function(t1, t2)
  for i, v in ipairs(t1) do if t2[i] ~= v then return false end end
  for i, v in ipairs(t2) do if t1[i] ~= v then return false end end
  return true
end

local function test(opts)
  print'Eyeballs test, should be 1, 2, 3, 4, 5 do'
  io.write'  ' print(take(10, 1, 2, 3, 4, 5)) print'end'
  
  -- Generate test table
  local tests = gen_tests(opts)
  
  -- Perform tests
  for _, test in pairs(tests) do
    io.write'test'
    local result = table.pack(take(test.n, table.unpack(test.varargs)))
    assert(cmp(result, test.result))
    print' = true'
  end
end

test{
  sizes = {
    1000, -- Naive implementations can handle that
    10000, -- Naive implementations can’t handle that
    -- 1000000, -- Table.unpack fails here
  }
}
