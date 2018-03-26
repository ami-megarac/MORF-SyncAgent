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

package.path = package.path .. ";./extensions/ipmi/?.lua;./libs/?.lua;./libs/?;"

local utils = require('utils')
local notify = require("subagents.notify")
local posix = require("posix")
utils.daemon("/var/run/sync-agent.pid")

local extension_agents = {}

-- Getting all agents from extensions
local extension_modules = utils.get_modules("extensions", "agent")
utils.array_merge(extension_agents, extension_modules)

local oem_modules = utils.get_modules("oem", "agent")
utils.array_merge(extension_agents, oem_modules)

while true do
    notify()

    for _i, agent in pairs(extension_agents) do
        agent()
    end
    os.execute("sleep 0.1")
end