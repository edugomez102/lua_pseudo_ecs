------------
-- Editor funcs
--
local editor_funcs = {
  style  = {},
  window = {},
}
local imgui
function editor_funcs.init(p_imgui)
  imgui = p_imgui
end

function editor_funcs.style.basic()
  imgui.PushStyleVar("ImGuiStyleVar_WindowRounding", 0);
  imgui.PushStyleVar("ImGuiStyleVar_WindowBorderSize", 1);
end

-------------------------------------------------
-- DockSpace
-------------------------------------------------

local dockspace_flags = {
  "ImGuiDockNodeFlags_PassthruCentralNode",
  "ImGuiDockNodeFlags_DockSpace"
}
local dockwindow_flaggs = {
  "ImGuiWindowFlags_NoTitleBar",
  "ImGuiWindowFlags_NoCollapse",
  "ImGuiWindowFlags_NoResize",
  "ImGuiWindowFlags_NoMove",
  "ImGuiWindowFlags_NoBringToFrontOnFocus",
  "ImGuiWindowFlags_NoNavFocus",
}
local dockspace_id = 1

---
--- Create DockSpace to which all windws will dock
---
function editor_funcs.main_dockspace()
  imgui.SetNextWindowPos(0, 0)
  imgui.SetNextWindowSize(1280, 720)
  imgui.Begin("DockSpace " .. dockspace_id , true, dockwindow_flaggs)
  imgui.DockSpace(dockspace_id, 0, 0, dockspace_flags)
  imgui.End()
end

-------------------------------------------------
-- Windows
-------------------------------------------------

local num = 1.0
local entity_editor = require("engine.editor.entity_editor")
function editor_funcs.window.editor(EM, SM)
  imgui.Begin("Entity list")
  num = imgui.SliderInt("SliderInt", num, 1, #EM.storage);
  if imgui.TreeNode("entity dump") then
    imgui.Text(table.dump(EM.storage[num]))
    imgui.TreePop()
  end
  imgui.Separator()
  imgui.End()

  -- TODO move
  entity_editor(EM, SM, imgui, num)
end

function editor_funcs.window.create(EM, SM, bools)
  imgui.Begin("Create")
  bools.render_collider = imgui.Checkbox("render_collider", bools.render_collider)
  if imgui.Button("new") then
    EM:create_entity{
      type = E_TYPES.enemy,
      cmps = {
        transform = {
          pos = {
            x = 10, y = 10
          }
        },
        physics = {vel = 5},
        render    = {
          w = 40,
          h = 40,
          color = {255, 255, 255 },
          -- sprite = "test"
        },
        ai = {
          patrol = "patrol_02",
          behs = {
            move = "patrol_move",
          }
        },
        collision = {
          beh = "change_color",
          w = 40,
          h = 40,
        }
      }
    }
  end
  imgui.Text("test")
  imgui.End()
end

function editor_funcs.window.nono(EM, SM, bools)
  imgui.Begin("SM test")
  imgui.Text(table.dump(SM))
  imgui.End()
end

local scene_factor = 0.65 -- TODO improve
function editor_funcs.scene_window(canvas)
  imgui.Begin("Scene", false , "HorizontalScrollbar")
  scene_factor = imgui.SliderFloat("Zoom", scene_factor, 0, 10)
  imgui.SameLine()
  if imgui.Button("Reset Zoom") then scene_factor = 0.65 end
  imgui.BeginChild("game_scene")
  imgui.Image(canvas, 1280 * scene_factor, 720 * scene_factor)
  imgui.EndChild()

  imgui.End()
end

-- TODO improve
local RM = require("game.man.resource_man")

local rm_canvas = love.graphics.newCanvas(100, 100)
function editor_funcs.window.rm()
  imgui.Begin("Resource Manager")

  for key, value in pairs(RM.sprites) do
    rm_canvas = love.graphics.newCanvas(100, 100)
    love.graphics.setCanvas(rm_canvas)
      -- love.graphics.clear(0, 0, 0) TODO ???
      love.graphics.draw(value)
    love.graphics.setCanvas()

    imgui.BeginGroup()
    imgui.Bullet()
    imgui.Image(rm_canvas, 40 , 40 )
    imgui.SameLine()
    imgui.Text(key)
    imgui.EndGroup()
    if (imgui.IsItemHovered()) then
      imgui.BeginTooltip()
      imgui.Image(rm_canvas, 300, 300)
      imgui.EndTooltip()
    end
  end

  imgui.End()
end

return editor_funcs

