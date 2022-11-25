------------
-- AI System
--
local sys_ai = {}

--- Contains ai behaviour funcs 
---@table ai_beh
local ai_beh

---
--- Init system.
--- Inits local fields
---
---@param Game table
function sys_ai:init(Game)
  ai_beh = Game.beh.ai
end

local function update_one(p_e)
  local cmp_ai  = p_e.cmps.ai
  -- TODO check
  if cmp_ai.behs.move then
    ai_beh[cmp_ai.behs.move](p_e)
  end
end

---
--- Updates system
---
---@param EM table
function sys_ai.update(EM)
  EM:forall({"transform", "ai"},
  function(entity)
    update_one(entity)
  end)
end

return sys_ai
