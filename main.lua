require("modules.table_")
-- local e   = require("man.entity")
local EM  = require("man.entity_man")
local SM  = require("man.sys_man")

function love.load()
  EM:init_from_list("test")
  SM:init()
end

function love.update(dt)
  EM:update()
  SM:update(EM.storage)

  -- print(EM.storage[1].cmps.transform.pos.x)
  -- print(EM.storage[2].id)
end

