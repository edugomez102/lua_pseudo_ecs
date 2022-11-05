local e  = require("man.entity")
local EM = require("man.entity_man")
local SM = require("man.sys_man")

local cmp_transform  = require("cmp.transform")
local cmp_physics    = require("cmp.physics")

EM:create_entity(e.new({
  type = "test",
  cmps = {
    transform = cmp_transform:new({}),
    physics   = cmp_physics:new({vx = 1, vy = 1})
  }
}))

-- print(EM.storage[1].id)
-- print(EM.storage[1].type)
-- print(EM.storage[1].cmps[1].vx)
-- print(EM.storage[1].cmps["physics"].vx)
-- print(EM.storage[1].cmps.physics.vx)

while true do
  EM:update()
  SM:update(EM.storage)

  print(EM.storage[1].cmps.transform.position.x)
end
