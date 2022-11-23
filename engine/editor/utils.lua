local utils = {}

function utils.help_marker(imgui, desc)
  imgui.TextDisabled("(?)")
  if imgui.IsItemHovered() then

    imgui.BeginTooltip()
    imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0);
    imgui.TextUnformatted(desc)
    imgui.PopTextWrapPos();
    imgui.EndTooltip()
  end
end

function utils.layout(imgui)
  imgui.SetNextWindowBgAlpha(0.30)
  if imgui.Begin("overlay", true, {
    "ImGuiWindowFlags_NoDocking",
    "ImGuiWindowFlags_NoTitleBar",
    "ImGuiWindowFlags_NoResize",
    "ImGuiWindowFlags_AlwaysAutoResize",
    "ImGuiWindowFlags_NoSavedSettings",
    "ImGuiWindowFlags_NoFocusOnAppearing",
    "ImGuiWindowFlags_NoNav"
  }) then
    imgui.Text("overlay Text")
    imgui.End()
  end
end

return utils
