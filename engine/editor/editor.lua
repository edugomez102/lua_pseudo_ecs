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
  for _, fun in pairs(editor_funcs.window) do
    fun(editor_EM, editor_SM)
  end
  self.imgui.Render()
end


return Editor
