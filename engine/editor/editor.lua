------------
-- Editor
--
local Editor = {
  imgui = require("imgui"),
  bools = {
    render_collider = false
  }
}

local editor_funcs = require("engine.editor.funcs")
editor_funcs.init(Editor.imgui)

local editor_EM
local editor_SM
function Editor.init(EM, SM)
  editor_EM = EM
  editor_SM = SM
end

---
--- Sets style for imgui dockspace and updates it
---
local function update_dockspace()
  Editor.imgui.PushStyleColor("ImGuiCol_WindowBg", 0.1, 0.1, 0.1, 1.0)
  editor_funcs.main_dockspace()
  Editor.imgui.PopStyleColor()
end

---
--- Sets style for imgui windows and updates them
---
---@param canvas love.Canvas
local function update_windows(canvas, bools)
  Editor.imgui.PushStyleColor("ImGuiCol_WindowBg", 0.2, 0.2, 0.2, 1.0)
  for _, fun in pairs(editor_funcs.window) do
    fun(editor_EM, editor_SM, bools)
  end
  editor_funcs.scene_window(canvas)
  Editor.imgui.PopStyleColor()
end

---
--- Updates imgui
---
function Editor:update(canvas)
  editor_funcs.style.basic()

  -- Editor.imgui.ShowDemoWindow()
  update_dockspace()
  update_windows(canvas, Editor.bools)

  self.imgui.Render()
end

return Editor
