local sys_physics = {}

function sys_physics.init()
end

local function update_one(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_phy = p_e.cmps.physics

  cmp_tra.position.x = cmp_tra.position.x + cmp_phy.vx
  cmp_tra.position.y = cmp_tra.position.y + cmp_phy.vy

  -- print("sys_physics update one")
end

function sys_physics.update(storage)
  -- print("update sys_physics")
  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "physics"  ) then

       update_one(entity)
         -- print("hola")
     end

    -- print(entity.id)
    -- print(entity.type)
    -- print(entity.cmps.physics.vx)

  end
  -- ::continue::

end

return sys_physics
