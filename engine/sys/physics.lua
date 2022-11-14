------------
-- Physics System
--
local sys_physics = {}

---
--- Init system
---
---@param Game table
function sys_physics:init(Game)
end

local math_sqrt = math.sqrt
local function update_one(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_phy = p_e.cmps.physics

  -- local len = math_sqrt(cmp_phy.vx * cmp_phy.vx + cmp_phy.vy * cmp_phy.vy)
  -- print("len", len)

  -- if len > 0 then
  --   cmp_phy.vx = cmp_phy.vx / len
  --   cmp_phy.vy = cmp_phy.vy / len
  -- end

  cmp_tra.pos.x = cmp_tra.pos.x + cmp_phy.vx
  cmp_tra.pos.y = cmp_tra.pos.y + cmp_phy.vy

  -- print(cmp_phy.vx, cmp_phy.vy)
  -- print(cmp_tra.pos.x, cmp_tra.pos.y)

end

---
--- Updates system
---
---@param storage table
function sys_physics.update(storage)
  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "physics"  ) then

       update_one(entity)
     end
  end

end

return sys_physics
