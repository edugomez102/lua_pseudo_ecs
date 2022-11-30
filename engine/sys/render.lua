------------
-- Render System
--
local sys_render = {
  w_w = 1920,
  w_h = 1080
}
local canvas = nil

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
--- Updates system
---
---@param EM table
function sys_render.update(EM)
  function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0.1, 0, 1)

    EM:forall({"transform", "render"},
    function(entity)
      update_one(entity)
    end)

    love.graphics.setCanvas()
    love.graphics.reset()
    love.graphics.draw(canvas, 0, 0)
  end
end

return sys_render

