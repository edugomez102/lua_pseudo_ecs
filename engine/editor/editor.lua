------------
-- Editor
--
local Editor = {
  imgui = require("imgui")
}
local editor_EM
local editor_SM

local editor_funcs = require("engine.editor.funcs")
editor_funcs.init(Editor.imgui)

function Editor.init(EM, SM)
  editor_EM = EM
  editor_SM = SM
end

---
--- Updates
---
function Editor:update()
  editor_funcs.style.basic()

  Editor.imgui.PushStyleColor("ImGuiCol_WindowBg", 0.1, 0.1, 0.1, 1.0)
  editor_funcs.dock.test()
  editor_funcs.dock.test2()
  editor_funcs.dock.test3()
  Editor.imgui.PopStyleColor()

  Editor.imgui.PushStyleColor("ImGuiCol_WindowBg", 0.2, 0.2, 0.2, 1.0)
  for _, fun in pairs(editor_funcs.window) do
    fun(editor_EM, editor_SM)
  end
  Editor.imgui.PopStyleColor()

  self.imgui.Render()
end


return Editor
