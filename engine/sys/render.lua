local sys_render = {
  w_h = 1280,
  w_w = 720
}

local rensysRM
function sys_render:init(Game)
  rensysRM = Game.man.RM

  love.window.setFullscreen(true)
  -- love.window.setMode(self.w_h, self.w_w)
end

local function update_one(p_e)
  local cmp_tra = p_e.cmps.transform
  local cmp_ren = p_e.cmps.render

  love.graphics.setColor(cmp_ren.color)
  love.graphics.rectangle("fill", cmp_tra.pos.x, cmp_tra.pos.y, cmp_ren.w, cmp_ren.h)

  -- TODO provisional
  if cmp_ren.sprite then
    love.graphics.draw(rensysRM.sprites[cmp_ren.sprite], cmp_tra.pos.x, cmp_tra.pos.y)
  end
end

function sys_render.update(storage)
  function love.draw()
    for _, entity in pairs(storage) do
      if table.has_key(entity.cmps, "transform") and
         table.has_key(entity.cmps, "render"  ) then
         update_one(entity)
       end
    end
  end
end

return sys_render

