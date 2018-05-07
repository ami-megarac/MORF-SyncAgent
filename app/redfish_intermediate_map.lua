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

local utils = require("utils")

local map = {}
local temp_map = {}

-- Getting all the redfish_group_map entries from all the extensions
local extension_modules = utils.get_modules("extensions", "redfish_intermediate_map")

-- Putting the extension maps together
for _i, mod in pairs(extension_modules) do
    for _mod_map_i, entry in pairs(mod) do
        if entry.extend == true then
            table.insert(map, entry)
        else
            temp_map[entry.redis_key] = entry.group_name
        end         

    end
end

-- Getting all the redfish_group_map entries from all the OEMs
local oem_modules = utils.get_modules("oem", "redfish_intermediate_map")

-- Adding the OEM enties and overrriding any existing entries
for _i, mod in pairs(oem_modules) do
    for _mod_map_i, entry in pairs(mod) do
        if entry.extend == true then
            table.insert(map, entry)
        else
            temp_map[entry.redis_key] = entry.group_name
        end         
    end
end

-- Putting the result map in the correct format
for key, group in pairs(temp_map) do
    local entry_map = {}
    entry_map["redis_key"] = key
    entry_map["group_name"] = group

    table.insert(map, entry_map)
end

return map