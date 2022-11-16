------------
-- Main file of lua pseudo ecs.
-- Inits EM, SM and game.
-- Updates EM and SM.
require("modules.table_")

local Game   = require("game.game")
local EM     = require("engine.man.entity_man")
local SM     = require("engine.man.sys_man")
local Editor = require("engine.editor.editor")

local love_callbacks = require("engine.love_callbacks")

--- Inits Game and engine managers
function love.load()
  SM:init(Game, Editor)
  Game:load_level(EM, "level_test")

  Editor.init(EM, SM)
end

-- TODO variable game framerate

--- Update managers
---@param dt number delta time
function love.update(dt)
  EM:update()
  SM:update(EM.storage)

  Editor.imgui.NewFrame()
end

---
--- Run other love callbacks
---
love_callbacks(
  Editor
)
