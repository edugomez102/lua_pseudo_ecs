local sys_ai      = require("sys.ai")
local sys_physics = require("sys.physics")

--@class
-- System Manager
--
SM = {
  systems = {
    sys_ai,
    sys_physics
  }
}

function SM:init()
  for i = 1, #self.systems do
    self.systems[i].init()
  end
end

function SM:update(storage)
  for i = 1, #self.systems do
    self.systems[i].update(storage)
  end
end

return SM
