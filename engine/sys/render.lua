------------
-- Render System
--
local sys_render = {
  w_w = S_W,
  w_h = S_H
}
-- TODO make local
local canvas = nil

---@table Editor
local Editor

--- Game resouce manager
---@table Game_RM
local Game_RM

---
--- Init system
---
---@param Game table
function sys_render:init(Game)
  Game_RM = Game.man.RM

  canvas = love.graphics.newCanvas(self.w_w, self.w_h)
  -- love.window.setFullscreen(true)
  love.window.setMode(self.w_w, self.w_h)
end

function sys_render.init_editor(p_Editor)
  Editor = p_Editor
end

local function update_one(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_ren = p_e.cmps.render

  love.graphics.setColor(cmp_ren.color)
  love.graphics.rectangle("fill", cmp_tra.pos.x, cmp_tra.pos.y, cmp_ren.w, cmp_ren.h)

  -- TODO provisional
  if cmp_ren.sprite then
    love.graphics.draw(Game_RM.sprites[cmp_ren.sprite], cmp_tra.pos.x, cmp_tra.pos.y)
  end
end

---
--- Draws collider of entity
---
---@param p_e table
local function draw_entity_collider(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_col = p_e.cmps.collision

  love.graphics.setColor( 110 / 255 , 231 / 255 , 255 / 255, 0.6)
  love.graphics.rectangle("fill", cmp_tra.pos.x, cmp_tra.pos.y, cmp_col.w, cmp_col.h)
end

-- patorl point and current aim
local function draw_patrol_points(p_e)
  local cmp_ai = p_e.cmps.ai
  if cmp_ai.patrol == nil then return end
  local patrol = require("game.resources.patrol_data")[cmp_ai.patrol]
  love.graphics.setColor(0.8, 0, 0, 0.75)
  for i = 1, #patrol do
    love.graphics.rectangle("line", patrol[i][1], patrol[i][2], 15, 15)
  end
  love.graphics.setColor(0, 0.7, 0, 0.75)
  love.graphics.rectangle("line", cmp_ai.aim.x, cmp_ai.aim.y, 15, 15)
end

---
--- Updates system
---
---@param EM table
function sys_render.update(EM, dt)
  function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0.1, 0, 1)

    EM:forall({"transform", "render"},
    function(entity)
      update_one(entity)
      if table.has_key(entity.cmps, "collision") and
         Editor.bools.render_collider
        then
        draw_entity_collider(entity)
      end
      if table.has_key(entity.cmps, "ai") and
         Editor.bools.render_patrol
        then
        draw_patrol_points(entity)
      end
    end)

    love.graphics.setCanvas()
    love.graphics.reset()

    if OG_DEBUG then
      Editor:update(canvas)
    else
      love.graphics.draw(canvas, 0, 0)
    end
  end
end

return sys_render

