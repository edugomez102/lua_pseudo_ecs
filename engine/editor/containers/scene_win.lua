local entity_right_click = require("engine.editor.entity.right_click")

local scene_win_flags = {
  "ImGuiWindowFlags_NoBringToFrontOnFocus"
}

local scene_win_overlay_flags = {
  "ImGuiWindowFlags_NoBackground",
  "ImGuiWindowFlags_NoTitleBar",
  "ImGuiWindowFlags_NoResize",
  "ImGuiWindowFlags_NoDocking",
}

local scene_zoom = .60 -- TODO improve
local function entity_marker(p_e)
  if table.has_key(p_e.cmps, "collision") then
    return {
      x = p_e.cmps.collision.w * scene_zoom,
      y = p_e.cmps.collision.h * scene_zoom,
    }
  end
  if table.has_key(p_e.cmps, "render") then
    return {
      x = p_e.cmps.render.w * scene_zoom,
      y = p_e.cmps.render.h * scene_zoom,
    }
  end
end

-- TOOD drag work with zoom
local function scene_overlay(Editor, EM)
  local imgui = Editor.imgui

  -- TODO fit imgui.Image
  imgui.PushStyleColor("ImGuiCol_WindowBg", 0.8, 0.2, 0.2, 0.4)

  imgui.PushStyleColor("ImGuiCol_ButtonHovered", 0.8, 0.9, 0.3, 0.4)
  imgui.PushStyleColor("ImGuiCol_ButtonActive", 0.8, 0.9, 0.3, 0.8)
  imgui.PushStyleVar("ImGuiStyleVar_FrameBorderSize", 1.5)

  imgui.Begin("over scene", false, scene_win_overlay_flags)
  local m_x, m_y = imgui.GetMousePos()
  for i = 1, #EM.storage do local e = EM.storage[i]
    if table.has_key(e.cmps, "transform") and
       table.has_key(e.cmps, "render"  ) then
      local cmp_tra = e.cmps.transform
      local btn_size = {x = 10, y = 10}
      imgui.SetCursorPos(
        cmp_tra.pos.x * scene_zoom,
        cmp_tra.pos.y * scene_zoom)

      if Editor.bools.num == e.id then
        btn_size = entity_marker(e)
        imgui.PushStyleColor("ImGuiCol_Border", 1.0, 1.0, 0.0, 1.0)
        imgui.PushStyleColor("ImGuiCol_Button", 0.8, 0.0, 0.0, 0.2)
      else
        imgui.PushStyleColor("ImGuiCol_Border", 0, 0, 0, 0)
        imgui.PushStyleColor("ImGuiCol_Button", 0, 0, 0, 0)
      end
      if imgui.Button("## ov" .. e.id, btn_size.x, btn_size.y)
        then Editor.bools.num = e.id end
      if imgui.IsItemActive() then
        -- TODO fixed margin
        cmp_tra.pos.x = (m_x - 20) / scene_zoom
        cmp_tra.pos.y = (m_y - 80) / scene_zoom
      end
      if imgui.BeginPopupContextItem() then
        entity_right_click(imgui, e, EM, Editor.info)
        imgui.EndPopup()
      end
      if imgui.IsItemHovered() or imgui.IsItemActive() then
        imgui.BeginTooltip()
        imgui.Text("ID: " .. e.id)
        local e_name = Editor.info.entity_names[e.id]
        if e_name then
          imgui.SameLine()
          imgui.Text(Editor.info.entity_names[e.id])
        end
        imgui.Text(cmp_tra.pos.x .. ", " .. cmp_tra.pos.y)
        imgui.EndTooltip()
      end
      imgui.PopStyleColor()
      imgui.PopStyleColor()
     end
  end
  imgui.PopStyleColor()
  imgui.PopStyleColor()
  imgui.PopStyleColor()
  imgui.PopStyleVar()
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

  imgui.BeginChild("game_scene", 0, 0, false, {
    "ImGuiWindowFlags_HorizontalScrollbar",
  })
  scn_win.size.x, scn_win.size.y = imgui.GetContentRegionAvail()
  if scn_win.size.x > S_W * scene_zoom then
    scn_win.size.x = S_W * scene_zoom
  end
  if scn_win.size.y > S_H * scene_zoom then
    scn_win.size.y = S_H * scene_zoom
  end
  -- scn_win.size.x, scn_win.size.y = S_W * scene_zoom, S_H * scene_zoom
  -- scn_win.pos.x, scn_win.pos.y   = imgui.GetCursorPos()
  scn_win.pos.x, scn_win.pos.y   = imgui.GetWindowPos()
  imgui.Image(canvas, S_W * scene_zoom, S_H * scene_zoom)
  imgui.EndChild()

  imgui.SetNextWindowPos(scn_win.pos.x, scn_win.pos.y)
  imgui.SetNextWindowSize(scn_win.size.x, scn_win.size.y)
  scene_overlay(Editor, storage)
  imgui.End()
end
