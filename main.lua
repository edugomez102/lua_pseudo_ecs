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
local canvas   --- buffer in which game is rendered

local Editor
------------------------------------------------------- DEBUG
if OG_DEBUG then Editor = require("engine.editor.editor") end
-------------------------------------------------------

---
--- Inits Game, engine managers and canvas
---
function love.load()
  ------------------------------------------------------- DEBUG
  if OG_DEBUG then
    SM:init(Game, Editor)
    Editor.init(EM, SM, Game)
  else
    SM:init(Game)
    -- TODO default scene
    Game:load_scene(EM, "player_portal")
  end
  -------------------------------------------------------

  canvas = SM.systems.render.canvas
end

---
--- Update managers
---
---@param dt number delta time
function love.update(dt)
  ------------------------------------------------------- DEBUG
  if OG_DEBUG then
    Editor.imgui.NewFrame()
    Editor:update(canvas)
  end
  -------------------------------------------------------

  EM:update()
  SM:update(EM, dt)
end

---
--- Draw game in full screen or in Editor
---
function love.draw()
  ------------------------------------------------------- DEBUG
  if   OG_DEBUG then Editor:draw()
  else love.graphics.draw(canvas, 0, 0)
  end
  -------------------------------------------------------
end

---
--- Run other love callbacks
---
------------------------------------------------------- DEBUG
if OG_DEBUG then require("engine.love_callbacks")(Editor) end
-------------------------------------------------------

