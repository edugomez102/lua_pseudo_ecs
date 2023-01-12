------------
-- Widget System
--
local sys_wid = {}

local widget_list = {}

---
--- Init system.
--- Inits local fields
---
---@param Game table
function sys_wid:init(Game)
end

local function update_one(p_e, EM)
  local cmp_wid = p_e.cmps.widget
  -- local cmp_tra = p_e.cmps.transform
  -- local cmp_ren = p_e.cmps.render
  -- if cmp_wid.hud then cmp_wid.hud() end

  if cmp_wid.hud then
    -- example
    local player = table.get_subtable(EM.storage, "type", E_TYPES.player)
    -- cmp_wid.text = player.cmps.transform.pos.x
  end
end

---
--- Updates system
---
---@param EM table
function sys_wid.update(EM)
  EM:forall({"transform", "render", "widget"},
  function(entity)
    update_one(entity, EM)
  end)
end

return sys_wid
