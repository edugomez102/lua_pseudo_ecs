local sys_physics = {}

function sys_physics:init()
end

local function update_one(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_phy = p_e.cmps.physics

  cmp_tra.pos.x = cmp_tra.pos.x + cmp_phy.vx
  cmp_tra.pos.y = cmp_tra.pos.y + cmp_phy.vy

end

function sys_physics.update(storage)
  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "physics"  ) then

       update_one(entity)
     end
  end

end

return sys_physics
