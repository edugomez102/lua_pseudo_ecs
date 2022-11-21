------------
-- Collision Behaviours
--
local col_beh = {}

---
--- Entity dies
---
---@param p_e table
function col_beh.die(p_e)
  p_e.type = E_TYPES.dead
end

---
--- Entity chages color
---
---@param p_e table
function col_beh.change_color(p_e)
  math.randomseed(os.clock() * 100000000000)
  p_e.cmps.render.color = {
    math.random(0, 255) / 255,
    math.random(0, 255) / 255,
    math.random(0, 255) / 255,
  }
end

return col_beh
