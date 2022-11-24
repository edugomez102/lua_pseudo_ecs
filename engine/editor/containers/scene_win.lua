local scene_win_flags = {
  "ImGuiWindowFlags_NoBringToFrontOnFocus"
}

local scene_win_overlay_flags = {
  "ImGuiWindowFlags_NoBackground",
  "ImGuiWindowFlags_NoTitleBar",
  "ImGuiWindowFlags_NoResize",
  "ImGuiWindowFlags_NoDocking",
}

-- TOOD drag work with zoom
local scene_zoom = .90 -- TODO improve
local function scene_overlay(Editor, storage)
  local imgui = Editor.imgui

  -- TODO fit imgui.Image
  Editor.imgui.PushStyleColor("ImGuiCol_WindowBg", 0.8, 0.2, 0.2, 0.4)

  imgui.Begin("over scene", false, scene_win_overlay_flags)
  imgui.PushStyleColor("ImGuiCol_Button", 0.8, 0.9, 0.3, 0.4)
  imgui.PushStyleColor("ImGuiCol_ButtonHovered", 0.8, 0.9, 0.3, 0.4)
  imgui.PushStyleColor("ImGuiCol_ButtonActive", 0.8, 0.9, 0.3, 0.8)
  local m_x, m_y = imgui.GetMousePos()
  for i = 1, #storage do local e = storage[i]
    if table.has_key(e.cmps, "transform") and
       table.has_key(e.cmps, "render"  ) then
      local cmp_tra = e.cmps.transform
      imgui.SetCursorPos(
        cmp_tra.pos.x * scene_zoom,
        cmp_tra.pos.y * scene_zoom)

      imgui.Button("## ov" .. e.id, 10, 10)
      if imgui.IsItemActive() then
        -- TODO fixed margin
        cmp_tra.pos.x = (m_x - 20) / scene_zoom
        cmp_tra.pos.y = (m_y - 80) / scene_zoom
      end
      if imgui.IsItemHovered() or imgui.IsItemActive() then
        imgui.BeginTooltip()
        imgui.Text(e.id)
        local e_name = Editor.info.entity_names[e.id]
        if e_name then imgui.Text(Editor.info.entity_names[e.id]) end
        imgui.Text(cmp_tra.pos.x .. ", " .. cmp_tra.pos.y)
        imgui.EndTooltip()
      end
     end
  end
  for _ = 1, 4 do imgui.PopStyleColor() end
  imgui.End()
end

local scn_win = { size = {}, pos = {} }
return function (Editor, canvas, storage)
  local imgui = Editor.imgui
  imgui.SetNextWindowDockID(1, "ImGuiCond_Once")
  imgui.Begin("Scene", false, scene_win_flags)
  scene_zoom = imgui.SliderFloat("Zoom", scene_zoom, 0, 10)
  imgui.SameLine()
  if imgui.Button("Reset Zoom") then scene_zoom = 0.65 end
  log(scn_win, "scn_win")

  Editor.imgui.PushStyleColor("ImGuiCol_WindowBg", 0.2, 0.7, 0.2, 0.4)
  imgui.BeginChild("game_scene", 0, 0, false, {
    "ImGuiWindowFlags_HorizontalScrollbar",
  })
  scn_win.size.x, scn_win.size.y = imgui.GetContentRegionAvail()
  -- scn_win.pos.x, scn_win.pos.y   = imgui.GetCursorPos()
  scn_win.pos.x, scn_win.pos.y   = imgui.GetWindowPos()
  imgui.Image(canvas, 1280 * scene_zoom, 720 * scene_zoom)
  imgui.EndChild()
  Editor.imgui.PopStyleColor()

  imgui.SetNextWindowPos(scn_win.pos.x, scn_win.pos.y)
  imgui.SetNextWindowSize(scn_win.size.x, scn_win.size.y)
  scene_overlay(Editor, storage)
  imgui.End()
end
