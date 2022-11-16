------------
-- editor funcs
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

local num = 1.0
local dockspace_id = 1
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

---
--- Creates dock space
---
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param id integer
---@return function
local function create_dockspace(id, x, y, w, h)
  local ds = function()
    imgui.SetNextWindowPos(x, y)
    imgui.SetNextWindowSize(w, h)
    imgui.Begin("DockSpace " .. id , true, dockwindow_flaggs)
    imgui.DockSpace(id, 0, 0, dockspace_flags)
    imgui.End()
  end
  return ds
end

--- array of dock_spaces, first arg is id
editor_funcs.dock = {
  create_dockspace(1, 0, 0, 300, 520),
  create_dockspace(2, 0, 520, 1280, 200),
  create_dockspace(3, 300, 0, 1280 - 300, 520)
}

function editor_funcs.window.hola(EM, SM)
  imgui.SetNextWindowDockID(dockspace_id, "ImGuiCond_Once")
  imgui.Begin("si hombr")
  num = imgui.SliderInt("SliderInt", num, 1, #EM.storage);
  imgui.Text(table.dump(EM.storage[num]))
  imgui.End()
end

function editor_funcs.window.create(EM, SM)
  imgui.SetNextWindowDockID(dockspace_id, "ImGuiCond_Once")
  imgui.Begin("Create")
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

function editor_funcs.window.nono(EM, SM)
  imgui.SetNextWindowDockID(2, "ImGuiCond_Once")
  imgui.Begin("SM test")
  imgui.Text(table.dump(SM))
  imgui.End()

end

local scene_factor = 0.65
function editor_funcs.scene_window(canvas)
  imgui.SetNextWindowDockID(3, "ImGuiCond_Once")
  imgui.Begin("scene" )

  imgui.BeginChild("game_scene")
  imgui.Image(canvas, 1280 * scene_factor, 720 * scene_factor)
  imgui.EndChild()

  imgui.End()
end

return editor_funcs

