local take = require'take'

local vec2 = function() return 2, 3 end

print(vec2())
print(select(2, vec2()))
print(take(1, vec2()))

local colors = function() return 'red', 'green', 'blue' end

print(colors())
print(select(2, colors()))
print(take(2, colors()))
print(take(1, select(2, colors())))
