
local show_log_line = true
local show_log_file = true

return function (imgui)
  imgui.Begin("Log")
  show_log_file = imgui.Checkbox("Show file", show_log_file)
  imgui.SameLine()
  show_log_line = imgui.Checkbox("Show line", show_log_line)
  -- print(get_log_list().templates.value)
  -- get_log_list().que = 1
  for name, ll in pairs(log_list) do
    if imgui.TreeNode(name) then
      if show_log_file then
        imgui.Text(" file:"); imgui.SameLine()
        imgui.Text(ll.debug_info.short_src)
      end
      if show_log_line then
        imgui.Text(" line:"); imgui.SameLine()
        imgui.Text(ll.debug_info.currentline)
      end
      imgui.PushStyleColor("ImGuiCol_Text", 0.2, 0.6, 0.2, 1.0)
      imgui.Text("value:"); imgui.SameLine()
      imgui.PopStyleColor()
      if type(ll.value) == "table" then
        imgui.Text(table.dump(ll.value))
      else
        imgui.Text(ll.value)
      end
      imgui.TreePop()
    end
  end
  imgui.End()
end
