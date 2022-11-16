local edit_cmp = {}

function edit_cmp.render(cmp, imgui)
  imgui.Text("cmp.ren")
  cmp.w = imgui.SliderInt("ren.w", cmp.w, 0, 200);
  cmp.h = imgui.SliderInt("ren.h", cmp.h, 0, 200);
end

function edit_cmp.collision(cmp, imgui)
  imgui.Text("cmp.col")
  cmp.w = imgui.SliderInt("col.w", cmp.w, 0, 200);
  cmp.h = imgui.SliderInt("col.h", cmp.h, 0, 200);
end

return function(EM, SM, imgui, num)
  -- for i = 1, #EM.storage do local entity = EM.storage[i]
  local entity = EM.storage[num]

  imgui.BeginGroup()
  for key, fun in pairs(edit_cmp) do
    if table.has_key(entity.cmps, key) then
      fun(entity.cmps[key], imgui)
    end
  end
  imgui.EndGroup()
  imgui.BeginGroup()
  imgui.EndGroup()
end
