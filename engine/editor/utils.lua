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

function utils.flex_group(imgui, item_margin)
  local window_visible_x2 = imgui.GetWindowPos() + imgui.GetWindowContentRegionMax()
  local last_button_x2    = imgui.GetItemRectMax()
  local next_button_x2    = last_button_x2 + item_margin
  if next_button_x2 < window_visible_x2 then
    imgui.SameLine()
  end
end

function utils.imgui_canvas(imgui, sprite, zoom, draw_fun)
  local w, h = sprite:getDimensions()
  local canvas = love.graphics.newCanvas(w, h)
  love.graphics.setCanvas(canvas)
    -- love.graphics.draw(sprite)
    draw_fun()
  love.graphics.setCanvas()
  imgui.Image(canvas, w * zoom, h * zoom )

end

return utils
