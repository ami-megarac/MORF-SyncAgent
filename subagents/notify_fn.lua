--[[
   Copyright 2018 American Megatrends Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--]]

package.path = package.path .. ";./libs/?.lua;./libs/?;"

--local sync = require("ipmi-sync-helpers")

local map = require("notify_fn_map")

local utils = require("utils")


local path = arg[1]
local file_name = arg[2]

for _i, callback in pairs(map[path]) do 
    if type(callback) == "function" then
        callback(file_name)
    elseif type(callback) == "string" then
        if file_name then
            utils.sub_process(callback, file_name)
        else
            utils.sub_process(callback)
        end
    end
end
