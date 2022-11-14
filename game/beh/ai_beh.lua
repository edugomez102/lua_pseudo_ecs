------------
-- AI Behaviours.
--
local ai_beh = {}

--- Funcs related to ai
---@table ai_utils
---@see game.beh.ai_utils
local ai_utils = require("game.beh.ai_utils")

function ai_beh.move_one(p_e)
  local cmp_phy = p_e.cmps.physics
  cmp_phy.vx = cmp_phy.vel

  if p_e.cmps.transform.pos.x > 500 then
    p_e.cmps.ai.behs.move = "move_two"
  end
end

function ai_beh.move_two(p_e)
  local cmp_phy = p_e.cmps.physics
  cmp_phy.vx = -cmp_phy.vel

  if p_e.cmps.transform.pos.x < 5 then
    p_e.cmps.ai.behs.move = "move_one"
  end
end

---
--- Follow a list of coords
---
---@param p_e table
function ai_beh.patrol_move(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_ai  = p_e.cmps.ai

  local patrol = require("game.resources.patrol_data")[cmp_ai.patrol]

  local to_x = patrol[cmp_ai.step][1]
  local to_y = patrol[cmp_ai.step][2]

  ai_utils.seek_to(p_e, to_x, to_y)

  -- if cmp_phy.vx == 0 and cmp_phy.vy == 0 then
  if cmp_tra.pos.x == to_x and cmp_tra.pos.y == to_y then
    if cmp_ai.step == #patrol then
      cmp_ai.step = 1
    else
      cmp_ai.step = cmp_ai.step + 1
    end
  end

end

return ai_beh
