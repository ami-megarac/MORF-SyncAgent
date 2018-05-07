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

package.path = package.path .. ";./libs/?;./libs/?.lua;../redfish/libs/?.lua;"
local redis = require('redis')
local CONFIG = require('config')

local params = {
    scheme = 'unix',
    path = CONFIG.redis_sock,
    -- host = CONFIG.redis_host,
    -- port = CONFIG.redis_port,
    timeout = 0
}

local db = redis.connect(params)

local sync_helpers = {}

sync_helpers.session_expire = function(groupname)
    db:set("Redfish:SessionService:Sessions:LastModified", os.time())
end

return sync_helpers