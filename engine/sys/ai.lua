local sys_ai = {}

local ai_beh
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

function sys_ai.update(storage)
  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "ai"  ) then

       update_one(entity)
     end
  end
end

return sys_ai
