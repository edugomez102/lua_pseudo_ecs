------------
-- Main file of lua pseudo ecs.
-- Inits EM, SM and game.
-- Updates EM and SM.
require("modules.ext")
require("engine.log")

local Game   = require("game.game")
local EM     = require("engine.man.entity_man")
local SM     = require("engine.man.sys_man")
local Editor = require("engine.editor.editor")

local love_callbacks = require("engine.love_callbacks")

--- Inits Game and engine managers
function love.load()
  SM:init(Game, Editor)
  Editor.init(EM, SM, Game)

  -- TODO default scene
  -- local default_scn = "quetal"
  -- Game:load_scene(EM, "quetal")
  -- local g_info  = Game.scenes[default_scn].editor_info
  -- Editor.info = g_info

end

-- TODO variable game framerate

--- Update managers
---@param dt number delta time
function love.update(dt)
  EM:update()
  SM:update(EM)

  Editor.imgui.NewFrame()
end

---
--- Run other love callbacks
---
love_callbacks(
  Editor
)
