local edit_cmp = {}

function edit_cmp.transform(cmp, imgui)
  imgui.Text("cmp.tra")
  cmp.pos.x = imgui.SliderInt("tra.pos.x", cmp.pos.x, 0, 600)
  cmp.pos.y = imgui.SliderInt("tra.pos.y", cmp.pos.y, 0, 600)
  cmp.scale.x = imgui.SliderInt("tra.scale.x", cmp.scale.x, 0, 200)
  cmp.scale.y = imgui.SliderInt("tra.scale.y", cmp.scale.y, 0, 200)
  cmp.rotation.x = imgui.SliderInt("tra.rotation.x", cmp.rotation.x, 0, 200)
  cmp.rotation.y = imgui.SliderInt("tra.rotation.y", cmp.rotation.y, 0, 200)
end

function edit_cmp.physics(cmp, imgui)
  cmp.vx = imgui.SliderFloat("phy.vx", cmp.vx, -20, 20)
  cmp.vy = imgui.SliderFloat("phy.vy", cmp.vy, -20, 20)
  cmp.vel = imgui.SliderFloat("phy.vel", cmp.vel, 0, 40)
end

function edit_cmp.render(cmp, imgui)
  imgui.Text("cmp.ren")
  cmp.w = imgui.SliderInt("ren.w", cmp.w, 0, 200)
  cmp.h = imgui.SliderInt("ren.h", cmp.h, 0, 200)
end

function edit_cmp.input(cmp, imgui)
  imgui.Text("keys " .. table.dump(cmp.keys))
  imgui.Text("gamepad " .. table.dump(cmp.gamepad))
end

local ai_beh  = require("game.beh.ai_beh")
local beh_selection = 1
function edit_cmp.ai(cmp, imgui)
  imgui.Text("cmp.ai")
  local behs = {}
  local i = 1
  for key, _ in pairs(ai_beh) do
    i = i + 1
    behs[# behs+1] = key
    if cmp.behs.move == key then
      beh_selection = i
    end
  end

  -- TODO fix
  beh_selection = imgui.Combo("move behs", beh_selection, behs, #behs)
  -- cmp.behs.move = behs[beh_selection]
  imgui.Text(cmp.behs.move)
  imgui.Text(beh_selection)
end

function edit_cmp.collision(cmp, imgui)
  imgui.Text("cmp.col")
  cmp.w = imgui.SliderInt("col.w", cmp.w, 0, 200)
  cmp.h = imgui.SliderInt("col.h", cmp.h, 0, 200)
end

local cmp_tab_flags = {
    "ImGuiTabBarFlags_Reorderable",
    "ImGuiTabBarFlags_FittingPolicyScroll",
    "ImGuiTabBarFlags_TabListPopupButton",
}

return function(EM, SM, imgui, num)
  -- for i = 1, #EM.storage do local entity = EM.storage[i]
  local entity = EM.storage[num]

  imgui.Begin("Edit Components")
  imgui.BeginTabBar("cmp_edit", cmp_tab_flags)
  for key, fun in pairs(edit_cmp) do
    if table.has_key(entity.cmps, key) then -- TOOD same cmp order
      if (imgui.BeginTabItem(key)) then
        fun(entity.cmps[key], imgui)
        imgui.EndTabItem()
      end
    end
  end
  imgui.EndTabBar()
  imgui.End()

end
