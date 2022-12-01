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

function ai_beh.no_move(p_e)
  local cmp_phy = p_e.cmps.physics
  cmp_phy.vx = 0
  cmp_phy.vy = 0
end

---
--- Follow a list of coords
---
---@param p_e table
function ai_beh.patrol_move(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_ai  = p_e.cmps.ai

  -- TODO improve
  local patrol = require("game.resources.patrol_data")[cmp_ai.patrol]

  cmp_ai.aim.x = patrol[cmp_ai.step][1]
  cmp_ai.aim.y = patrol[cmp_ai.step][2]

  ai_utils.seek_to(p_e, cmp_ai.aim.x, cmp_ai.aim.y)

  if cmp_tra.pos.x == cmp_ai.aim.x and cmp_tra.pos.y == cmp_ai.aim.y then
    if cmp_ai.step == #patrol then
      cmp_ai.step = 1
    else
      cmp_ai.step = cmp_ai.step + 1
    end
  end

end

function ai_beh.move_to_randon(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_ai  = p_e.cmps.ai

  -- local to_x = patrol[cmp_ai.step][1]
  -- local to_y = patrol[cmp_ai.step][2]
  -- print("x:" .. cmp_tra.pos.x, "y:" .. cmp_tra.pos.y ,"aimx:" .. cmp_ai.aim.x, "aimy:" .. cmp_ai.aim.y)

  if(cmp_tra.pos.x  - cmp_ai.aim.x == 0 and cmp_tra.pos.y - cmp_ai.aim.y == 0 ) or
    (cmp_ai.aim.x == 0 and cmp_ai.aim.y == 0) then

    math.randomseed(os.clock() * 100000000000)
    cmp_ai.aim.x = math.random(0, S_W)
    cmp_ai.aim.y = math.random(0, S_W)
    p_e.cmps.render.color = {
      -- 255, 0, 0
      math.random(0, 255) / 255,
      math.random(0, 255) / 255,
      math.random(0, 255) / 255,
    }
  end

  ai_utils.seek_to(p_e, cmp_ai.aim.x, cmp_ai.aim.y)
end

return ai_beh
