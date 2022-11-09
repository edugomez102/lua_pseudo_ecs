
--@class
-- System Manager
--
SM = {
  systems = {
    require("sys.render"),
    require("sys.physics"),
    require("sys.ai"),
    require("sys.input"),
    require("sys.collision"),
  }
}

function SM:init()
  for i = 1, #self.systems do
    self.systems[i]:init(self.systems)
  end
end

function SM:update(storage)
  for i = 1, #self.systems do
    self.systems[i].update(storage)
  end
end

return SM
