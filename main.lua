require("modules.table_")

local Game = require("game.game")
local EM   = require("engine.man.entity_man")
local SM   = require("engine.man.sys_man")

function love.load()
  SM:init(Game)
  Game:load_level(EM, "level_test")
end

function love.update(dt)
  EM:update()
  SM:update(EM.storage)
end

