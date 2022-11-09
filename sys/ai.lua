local sys_ai = {}
local ai_beh = require("game.beh.ai_beh")

function sys_ai:init()
end

local function update_one(p_e)
  local cmp_ai  = p_e.cmps.ai
  ai_beh[cmp_ai.beh](p_e)
end

function sys_ai.update(storage)
  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "ai"  ) then

       update_one(entity)
     end
  end
end

return sys_ai
