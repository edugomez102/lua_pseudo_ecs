------------
-- Render System
--
local sys_render = {
  w_w = 1280,
  w_h = 720
}
-- TODO make local
canvas = nil

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

---
--- Updates system
---
---@param storage table
function sys_render.update(storage)
  function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0.1, 0, 1)

    for _, entity in pairs(storage) do
      if table.has_key(entity.cmps, "transform") and
         table.has_key(entity.cmps, "render"  ) then

        update_one(entity)
        -- if table.has_key(entity.cmps, "collision") then
        --  draw_entity_collider(entity)
        -- end
       end
    end

    love.graphics.setCanvas()
      -- -- love.graphics.setBlendMode("alpha")

    love.graphics.reset()

    -- love.graphics.draw(canvas, 0, 0)
    Editor:update()
  end
end

return sys_render

