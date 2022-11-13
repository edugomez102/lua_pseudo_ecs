
---
--- System Manager
---
local SM = {
  systems = {
    require("engine.sys.render"),
    require("engine.sys.physics"),
    require("engine.sys.ai"),
    require("engine.sys.input"),
    require("engine.sys.collision"),
  }
}

function SM:init(Game)
  for i = 1, #self.systems do
    self.systems[i]:init(Game)
  end
end

function SM:update(storage, dt)
  for i = 1, #self.systems do
    self.systems[i].update(storage, dt)
  end
end

return SM
