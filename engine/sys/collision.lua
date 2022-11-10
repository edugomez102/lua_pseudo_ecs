local sys_collision = {}

-- TODO improve
local max_w = 1280
local max_h = 720

local col_beh = {}
function sys_collision:init(Game)
  col_beh = Game.beh.col
end

--
-- Checks if entity position is out of screen
--
local function check_border(p_e)
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

---
--- Checks position and size between player and other entities
--- if colliding, players col_beh is called
---
local function check_player_collision(player, p_e)
  -- player cmps
  local p_cmp_tra = player.cmps.transform
  local p_cmp_ren = player.cmps.render

  local cmp_tra = p_e.cmps.transform
  local cmp_ren = p_e.cmps.render
  local cmp_col = p_e.cmps.collision

  if p_cmp_tra.pos.x + p_cmp_ren.w >= cmp_tra.pos.x
     and
     p_cmp_tra.pos.x <= cmp_tra.pos.x + cmp_ren.w
     and
     p_cmp_tra.pos.y + p_cmp_ren.h >= cmp_tra.pos.y
     and
     p_cmp_tra.pos.y <= cmp_tra.pos.y + cmp_ren.h
    then
      col_beh[cmp_col.beh](p_e)
  end
end

local function update_one(p_e)
  check_border(p_e)
end

function sys_collision.update(storage)
  -- TODO move or improve
  local player = table.get_subtable(storage, "type", "player")

  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "collision"  ) then

       update_one(entity)
     end
  end

  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
      table.has_key(entity.cmps, "collision") and
      entity.type ~= "player" then

       check_player_collision(player, entity)
     end
  end
end

return sys_collision
