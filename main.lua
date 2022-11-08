require("modules.table_")
local e   = require("man.entity")
local EM  = require("man.entity_man")
local SM  = require("man.sys_man")
local CMP = require("cmp.cmp_all")

EM:create_entity(e.new({
  type = "test",
  cmps = {
    transform = CMP.transform({}),
    physics   = CMP.physics({vx = 1, vy = 1})
  }
}))

EM:create_entity(e.new({}))

-- print(EM.storage[1].id)
-- print(EM.storage[1].type)
-- print(EM.storage[1].cmps[1].vx)
-- print(EM.storage[1].cmps["physics"].vx)
-- print(EM.storage[1].cmps.physics.vx)

while true do
  EM:update()
  SM:update(EM.storage)

  print(EM.storage[1].cmps.transform.position.x)
  print(EM.storage[2].id)
end
