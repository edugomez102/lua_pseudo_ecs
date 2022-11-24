
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
local topbar_margin = 16

---
--- Create DockSpace to which all windws will dock
---
return function (imgui)
  imgui.SetNextWindowPos(0, topbar_margin)
  imgui.SetNextWindowSize(1920, 1080 - topbar_margin)
  imgui.Begin("DockSpace " .. dockspace_id , true, dockwindow_flaggs)
  imgui.DockSpace(dockspace_id, 0, 0, dockspace_flags)
  imgui.End()
end

