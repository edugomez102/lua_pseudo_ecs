
local sys_render = {}

function sys_render.init()
  love.window.setMode(1280, 720)
  -- love.window.setFullscreen(true)
end

local function update_one(e_p)
  -- love.graphics.setColor(255, 0, 0)
  -- love.graphics.rectangle("fill", 0, 0, 40, 40)
end


function sys_render.update(storage)
  function love.draw()
    -- update_one()
  end
end

return sys_render
-- ...
