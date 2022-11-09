local sys_collision = {}

-- TODO improve
local max_w = 1280
local max_h = 720

function sys_collision:init(systems)
  -- print(systems["render"].w_h)
end

local function update_one(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_phy = p_e.cmps.physics
  local cmp_ren = p_e.cmps.render

  if(cmp_tra.pos.x >= max_w - cmp_ren.w or cmp_tra.pos.x <= 0) then
    print("collision X")
    cmp_phy.vx = 0
  end
  if(cmp_tra.pos.y >= max_h - cmp_ren.h or cmp_tra.pos.y <= 0) then
    print("collision Y")
    cmp_phy.vy = 0
  end

end

function sys_collision.update(storage)
  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "collision"  ) then
       update_one(entity)
     end
  end
end

return sys_collision
