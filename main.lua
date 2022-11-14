require("modules.table_")

local Game = require("game.game")
local EM   = require("engine.man.entity_man")
local SM   = require("engine.man.sys_man")

function love.load()
  SM:init(Game)
  Game:load_level(EM, "level_test")

  EM:create_entity{
    type = E_TYPES.enemy,
    cmps = {
      transform = {
        pos = {
          x = 100, y = 3
        },
      },
      render = {
        w = 30,
        h = 40,
        color = {255, 0, 5}
      }
    }
  }
end

-- TODO variable game framerate
function love.update(dt)
  EM:update()
  SM:update(EM.storage)
end

