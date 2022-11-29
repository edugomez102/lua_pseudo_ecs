local edit_cmp = {}
local RM = require("game.man.resource_man")

-------------------------------------------------
-- Combos of cmp
-------------------------------------------------

---
--- Create combo data to use in local cmp_comb
---
---@param source_table table source of data
---@return table to be saved in cmp_comb
local function create_cmp_comb(source_table)
  local t = {}
  t.array, t.map = {}, {}
  t.select = -1
  local i = 1
  for key, _ in pairs(source_table) do
    t.array[i] = key
    t.map[i] = key
    i = i + 1
  end
  return t
end

local cmp_comb = {
  sprite  = create_cmp_comb(RM.sprites),
  col_beh = create_cmp_comb(require("game.beh.col_beh")),
  ai_beh  = create_cmp_comb(require("game.beh.ai_beh")),
}

---
--- Update combo
---
---@param imgui table
---@param cmp table cmp or cmp field
---@param combo_key string key of cmp_comb
---@param cmp_key string key of cmp second arg
local function update_cmp_combo(imgui, cmp, cmp_key, combo_key)
  for j = 1, #cmp_comb[combo_key].array do
    if cmp_comb[combo_key].array[j] == cmp[cmp_key] then
      cmp_comb[combo_key].select = j
    end
  end
  cmp_comb[combo_key].select = imgui.Combo(tostring(combo_key),
    cmp_comb[combo_key].select, cmp_comb[combo_key].array, #cmp_comb[combo_key].array)

  if cmp_comb[combo_key].select > 0 then
    cmp[cmp_key] = cmp_comb[combo_key].map[cmp_comb[combo_key].select]
  end
end

-------------------------------------------------
-- Cmps edit panels
-------------------------------------------------

function edit_cmp.transform(cmp, imgui)
  imgui.Text("cmp.tra")
  cmp.pos.x, cmp.pos.y =
  imgui.SliderInt2("trs pos", cmp.pos.x, cmp.pos.y, 0, 1080)
  cmp.scale.x, cmp.scale.y =
  imgui.SliderInt2("tra scale", cmp.scale.x, cmp.scale.y, 0, 200)
  cmp.rotation.x, cmp.rotation.y =
  imgui.SliderInt2("tra rotation", cmp.rotation.x, cmp.rotation.y, 0, 200)
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

  cmp.color[1],
  cmp.color[2],
  cmp.color[3] = imgui.ColorEdit3("cmp.color",
  cmp.color[1],
  cmp.color[2],
  cmp.color[3])

  update_cmp_combo(imgui, cmp, "sprite", "sprite")
end

function edit_cmp.input(cmp, imgui)
  for key, value in pairs(cmp.keys) do
    if love.keyboard.isDown(key) then
      imgui.PushStyleColor("ImGuiCol_Text", 1, 0, 0, 1)
      imgui.Text(key)
      imgui.PopStyleColor()
    else
      imgui.Text(key)
    end
    imgui.SameLine()
    imgui.Text(": " .. value)
  end
  imgui.Separator()

  for key, value in pairs(cmp.gamepad) do
    imgui.Text(key .. ": " .. value)
  end
  -- imgui.Text("keys " .. table.dump(cmp.keys))
  -- imgui.Text("gamepad " .. table.dump(cmp.gamepad))
end

function edit_cmp.ai(cmp, imgui)
  imgui.Text("cmp.ai")
  update_cmp_combo(imgui, cmp.behs, "move", "ai_beh")
  cmp.aim.x, cmp.aim.y =
  imgui.SliderInt2("aim", cmp.aim.x, cmp.aim.y, 0, 1080)
end

function edit_cmp.collision(cmp, imgui)
  imgui.Text("cmp.col")
  cmp.w = imgui.SliderInt("col.w", cmp.w, 0, 200)
  cmp.h = imgui.SliderInt("col.h", cmp.h, 0, 200)
  update_cmp_combo(imgui, cmp, "beh", "col_beh")

end

local cmp_tab_flags = {
  "ImGuiTabBarFlags_Reorderable",
  "ImGuiTabBarFlags_FittingPolicyScroll",
  "ImGuiTabBarFlags_TabListPopupButton",
}

---
--- Checks if entity contains component and 
--- if so, creates edit panel for that component
---
---@param EM table
---@param SM table
---@param imgui table
---@param num integer selected entity index
return function(EM, SM, imgui, num)
  local entity = EM.storage[num]
  imgui.Begin("Edit Components")
  imgui.BeginTabBar("cmp_edit", cmp_tab_flags)
  if entity == nil then return end
  for key, fun in pairs(edit_cmp) do
    if table.has_key(entity.cmps, key) then -- TOOD same cmp order
      if imgui.BeginTabItem(key) then
        -- TODO improve :(
        do
          if imgui.Button("delete this component") then
            EM.delete_cmp(entity, key) return
          end
          imgui.Separator()
        end

        fun(entity.cmps[key], imgui)
        imgui.EndTabItem()
      end
    end
  end
  imgui.EndTabBar()
  imgui.End()
end
