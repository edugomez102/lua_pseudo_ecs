------------
-- Collision System
--
local sys_collision = {}


--- Margins of screen
---@table m
local m = {
  min_x = 0,      --- integer screen min x
  min_y = 0,      --- integer screen min y
  max_x = 1920,   --- integer screen max x
  max_y = 1080     --- integer screen max y
}

--- Contains entity collision funcs 
---@see game.beh.col_beh
---@table col_beh
local col_beh

---
--- Init system
---
---@param Game table
function sys_collision:init(Game)
  col_beh = Game.beh.col
end

---
--- Checks if entity position is out of screen
---
---@param p_e table
local function check_border(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_col = p_e.cmps.collision

  -- X
  if(cmp_tra.pos.x <= m.min_x) then
      cmp_tra.pos.x = m.min_x
  end
  if(cmp_tra.pos.x >= m.max_x - cmp_col.w) then
    cmp_tra.pos.x = m.max_x - cmp_col.w
  end

  -- Y
  if(cmp_tra.pos.y <= m.min_y) then
    cmp_tra.pos.y = m.min_y
  end
  if(cmp_tra.pos.y >= m.max_y - cmp_col.h) then
    cmp_tra.pos.y = m.max_y - cmp_col.h
  end
end

---
--- Checks position and size between player and other entities
--- if colliding, col_beh of p_e is called
---
---@param player table
---@param p_e table entity to check for collision
local function check_player_collision(player, p_e)
  local p_cmp_tra = player.cmps.transform
  local p_cmp_col = player.cmps.collision

  local cmp_tra = p_e.cmps.transform
  local cmp_col = p_e.cmps.collision

  if p_cmp_tra.pos.x + p_cmp_col.w >= cmp_tra.pos.x
     and
     p_cmp_tra.pos.x <= cmp_tra.pos.x + cmp_col.w
     and
     p_cmp_tra.pos.y + p_cmp_col.h >= cmp_tra.pos.y
     and
     p_cmp_tra.pos.y <= cmp_tra.pos.y + cmp_col.h
    then
      col_beh[cmp_col.beh](p_e)
  end
end

local function update_one(p_e)
  check_border(p_e)
end

---
--- Updates system
---
---@param storage table entity storage
function sys_collision.update(storage)

  local player = table.get_subtable(storage, "type", E_TYPES.player)
  -- TODO move or improve

  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "collision") then

       update_one(entity)
     end
  end

  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "collision") and
       entity.type ~= E_TYPES.player and player then

       check_player_collision(player, entity)
     end
  end
end

return sys_collision
