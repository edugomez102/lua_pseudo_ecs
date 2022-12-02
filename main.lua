------------
-- Main file of lua pseudo ecs.
-- Inits EM, SM and game.
-- Updates EM and SM.
require("modules.ext")
require("lib.load_libs")
require("engine.log")

local Game   = require("game.game")
local EM     = require("engine.man.entity_man")
local SM     = require("engine.man.sys_man")

local Editor

if OG_DEBUG then ------------ || DEBUG
  Editor = require("engine.editor.editor")
end

--- Inits Game and engine managers
function love.load()

if OG_DEBUG then ------------ || DEBUG
  SM:init(Game, Editor)
  Editor.init(EM, SM, Game)
else             ------------ || RELEASE
  SM:init(Game)

  -- TODO default scene
  Game:load_scene(EM, "player_portal")
end

end

--- Update managers
---@param dt number delta time
function love.update(dt)
  EM:update()
  SM:update(EM, dt)

if OG_DEBUG then ------------ || DEBUG
  Editor.imgui.NewFrame()
end

end

---
--- Run other love callbacks
---
if OG_DEBUG then ------------ || DEBUG
  local love_callbacks = require("engine.love_callbacks")
  love_callbacks(Editor)
end
