------------
-- Main file of lua pseudo ecs.
-- Inits EM, SM and game.
-- Updates EM and SM.
require("modules.ext")

local Game   = require("game.game")
local EM     = require("engine.man.entity_man")
local SM     = require("engine.man.sys_man")

--- Inits Game and engine managers
function love.load()
  SM:init(Game)
  Game:load_scene(EM, "scene_01")
end

-- TODO variable game framerate

--- Update managers
---@param dt number delta time
function love.update(dt)
  EM:update()
  SM:update(EM)
end
