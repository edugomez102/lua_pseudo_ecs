------------
-- Main file of lua pseudo ecs.
-- Inits EM, SM and game.
-- Updates EM and SM.

require("modules.table_")

local Game = require("game.game")
local EM   = require("engine.man.entity_man")
local SM   = require("engine.man.sys_man")

--- Inits Game and engine managers
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

--- Update managers
---@param dt number delta time
function love.update(dt)
  EM:update()
  SM:update(EM.storage)
end

