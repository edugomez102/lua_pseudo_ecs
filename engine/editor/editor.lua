------------
-- Editor
--
local Editor = {
  imgui = require("imgui"),
  bools = {
    render_collider = false,
    render_patrol = true
  },
  info = {
    dirty = false,
    -- -- deletion ???
    entity_names = {}
  }
}

local editor_EM
local editor_SM
local editor_Game
function Editor.init(EM, SM, Game)
  editor_EM = EM
  editor_SM = SM
  editor_Game = Game
end

local editor_funcs = require("engine.editor.funcs")
editor_funcs.init(Editor.imgui, Editor.info)

---
--- Sets style for imgui dockspace and updates it
---
local function update_dockspace()
  Editor.imgui.PushStyleColor("ImGuiCol_WindowBg", 0.1, 0.1, 0.1, 1.0)
  editor_funcs.main_dockspace(Editor.imgui)
  Editor.imgui.PopStyleColor()
end

---
--- Sets style for imgui windows and updates them
---
---@param canvas love.Canvas
local function update_windows(canvas, bools)
  Editor.imgui.PushStyleColor("ImGuiCol_WindowBg", 0.2, 0.2, 0.2, 1.0)
  editor_funcs.scene_window(Editor, canvas, editor_EM.storage)
  for _, fun in pairs(editor_funcs.window) do
    fun(editor_EM, editor_SM, bools)
  end
  Editor.imgui.PopStyleColor()
end

---
--- Updates imgui
---
function Editor:update(canvas)
  log(Editor.info, "Editor.info")
  editor_funcs.style.push_basic()

  Editor.imgui.ShowDemoWindow()
  editor_funcs.main_menu(Editor, editor_EM,
    editor_SM, editor_Game)

  update_dockspace()
  update_windows(canvas, Editor.bools)
  editor_funcs.log_window(Editor.imgui)

  editor_funcs.style.pop_basic()

  self.imgui.Render()
end

return Editor
