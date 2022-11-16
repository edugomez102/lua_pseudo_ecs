------------
-- Render System
--
local sys_render = {
  w_h = 1280,
  w_w = 720
}

--- Game resouce manager
---@table Game_RM
local Game_RM

---
--- Init system
---
---@param Game table
function sys_render:init(Game)
  Game_RM = Game.man.RM

  -- love.window.setFullscreen(true)
  love.window.setMode(self.w_h, self.w_w)
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
    for i = 1, #storage do local entity = storage[i]
      if table.has_key(entity.cmps, "transform") and
         table.has_key(entity.cmps, "render"  ) then

        update_one(entity)
        if table.has_key(entity.cmps, "collision") then
         draw_entity_collider(entity)
        end
       end
    end
  end
end

return sys_render

