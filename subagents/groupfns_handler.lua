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

local utils = require("utils")
local _ = require("underscore")
local map = require("redfish_group_map")

if next(map) == nil then
    print("Empty group map. Exiting...")
    os.exit()
end

local arg_i = 1

while arg[arg_i] do
    local value = arg[arg_i]
    local grp_segments = utils.split(value, ':')
    local group_name = grp_segments[1]
    local group_args = _.slice(grp_segments, 2, #grp_segments-1)

    local filtered_map = _.select(map, function(item) 
        -- Check if the incoming redis key is matching any registered item in the redfish map
        return string.find(group_name, "^" .. item.group_name .. "$")
    end)
    
    -- invoke all matching item's function
    for lind, litem in ipairs(filtered_map) do
        for fn_index, fn_ptr in ipairs(litem.sync_fns) do
            local result = fn_ptr(unpack(grp_segments))
            --litem.libipmi_context[litem.libipmi_fn](litem.libipmi_context, value)
        end
    end

    arg_i = arg_i + 1
end
