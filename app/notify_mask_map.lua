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

local posix = require("posix")
local _ = require("underscore")
local utils = require("utils")
local inotify = require('inotify')

os.execute( "touch /tmp/reload-notify")

local map = {}
map['/tmp/reload-notify'] = {inotify.IN_MODIFY}

-- Getting notify_map entries from all the extensions
local extension_modules = utils.get_modules("extensions", "notify_mask_map")
for _i, mod in pairs(extension_modules) do
    _.extend(map, mod)
end

local extension_extend_modules = utils.get_modules("extensions", "notify_mask_extend_map")
for _i, mod in pairs(extension_extend_modules) do
    utils.extend_notify_map(map, mod)
end

-- Getting notify_map entries from all the OEMs
local oem_modules = utils.get_modules("oem", "notify_mask_map")
for _i, mod in pairs(oem_modules) do
    _.extend(map, mod)
end

local oem_extend_modules = utils.get_modules("oem", "notify_mask_extend_map")
for _i, mod in pairs(oem_extend_modules) do
    utils.extend_notify_map(map, mod)
end

return map