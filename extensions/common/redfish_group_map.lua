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

package.path = package.path .. ";./extensions/common/?.lua;./libs/?;./libs/?.lua;"


local sync = require("sync-helpers")

-- When the group is SET, the corresponding sync functions will be triggered with one argument: the changed group name as lua string
local redfish_map = {

	{group_name="SessionExpire", sync_fns={sync.session_expire}}
}

return redfish_map
