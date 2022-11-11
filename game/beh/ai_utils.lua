local ai_utils = {}

---
--- Returns new vx/y to follow a point
---
---@param pos integer x or y position of entity
---@param vel integer seek velocity
---@param to integer point to seek
---@return number vx or vy or entity after seek
local function follow_point_v(pos, vel, to)
  if pos > to then
    return -vel
  elseif pos < to then
    return vel
  end
  -- if pos == to
  return 0
end

---
--- Updates vx and vy of entity to follow a coord
---
---@param p_e table entity
---@param to_x number x position to follow
---@param to_y number y position to follow
function ai_utils.seek_to(p_e, to_x, to_y)
  local cmp_tra = p_e.cmps.transform
  local cmp_phy = p_e.cmps.physics

  cmp_phy.vx = follow_point_v(cmp_tra.pos.x, cmp_phy.vel, to_x)
  cmp_phy.vy = follow_point_v(cmp_tra.pos.y, cmp_phy.vel, to_y)

end

return ai_utils
