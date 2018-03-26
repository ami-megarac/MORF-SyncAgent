local ffi = require("ffi")

ffi.cdef[[
    int something();
]]

local test = ffi.load("test")

test.something()
