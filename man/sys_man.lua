
--@class
-- System Manager
--
SM = {
  systems = {
    require("sys.physics"),
    require("sys.ai"),
    require("sys.render")
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
