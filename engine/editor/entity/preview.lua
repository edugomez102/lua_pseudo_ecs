
-- local render_fun = require("engine.sys.render").update_one
return function (imgui, p_e, RM)
  imgui.Text("type: " .. p_e.type)
  imgui.Spacing()
  for key, _ in pairs(p_e.cmps) do
    imgui.Text(key)
  end
  if table.has_key(p_e.cmps, "render") then
    local cmp_ren = p_e.cmps.render
    local pv_canvas = love.graphics.newCanvas(50, 50)
    love.graphics.setCanvas(pv_canvas)
      -- render_fun(p_e)
        love.graphics.setColor(cmp_ren.color)
        love.graphics.rectangle("fill", 0, 0, cmp_ren.w, cmp_ren.h)
        if cmp_ren.sprite and RM then
          love.graphics.draw(RM.sprites[cmp_ren.sprite], 0, 0)
        end
        love.graphics.reset()
    love.graphics.setCanvas()
    imgui.Image(pv_canvas, 80, 80)
  end
end
