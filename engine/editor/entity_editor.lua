local edit_cmp = {}
local RM = require("game.man.resource_man")
local utils = require("engine.editor.utils")

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
  -- TODO
  -- fonts   = create_cmp_comb(RM.fonts),
  col_beh = create_cmp_comb(require("game.beh.col_beh")),
  ai_beh  = create_cmp_comb(require("game.beh.ai_beh")),
}

---
--- Update combo
---
---@param imgui table
---@param cmp table cmp or cmp.field
---@param cmp_key string key of second param cmp's field
---@param combo_key string key of @local cmp_comb
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
  imgui.SliderInt2("trs pos", cmp.pos.x, cmp.pos.y, 0, S_H)
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

  cmp.color[1], cmp.color[2], cmp.color[3] =
  imgui.ColorEdit3("cmp.color",
  cmp.color[1], cmp.color[2], cmp.color[3])

  imgui.Separator()

  -- TODO
  local sprite = RM.sprites[cmp.sprite]
  if cmp.sprite == nil then
    if imgui.Button("Add sprite")    then cmp.sprite = "sprite_default" end
  else
    if imgui.Button("Delete Sprite") then cmp.sprite = nil end
    cmp.w, cmp.h  = sprite:getDimensions()
  end

  if cmp.sprite ~= nil then
    update_cmp_combo(imgui, cmp, "sprite", "sprite")
  end
  imgui.Spacing()

  utils.imgui_canvas(imgui, sprite, 0.5, function()
    love.graphics.draw(sprite)
  end)
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
  -- TODO
  -- imgui.Text("keys " .. table.dump(cmp.keys))
  -- imgui.Text("gamepad " .. table.dump(cmp.gamepad))
  -- imgui.Text("mouse " .. table.dump(cmp.gamepad))
end

function edit_cmp.ai(cmp, imgui)
  imgui.Text("cmp.ai")
  update_cmp_combo(imgui, cmp.behs, "move", "ai_beh")
  cmp.aim.x, cmp.aim.y =
  imgui.SliderInt2("aim", cmp.aim.x, cmp.aim.y, 0, S_H)
end

local col_fit_sprite = false
function edit_cmp.collision(cmp, imgui)
  imgui.Text("cmp.col")
  col_fit_sprite = imgui.Checkbox("Fit sprite", col_fit_sprite)

  cmp.w = imgui.SliderInt("col.w", cmp.w, 0, 200)
  cmp.h = imgui.SliderInt("col.h", cmp.h, 0, 200)
  update_cmp_combo(imgui, cmp, "beh", "col_beh")

end

-- TODO
function edit_cmp.widget(cmp, imgui)
  imgui.Text("cmp.wid")
  cmp.w = imgui.SliderInt("wid.w", cmp.w, 0, 200)
  cmp.h = imgui.SliderInt("wid.h", cmp.h, 0, 200)

  cmp.text_color[1], cmp.text_color[2], cmp.text_color[3] =
  imgui.ColorEdit3("cmp.color",
  cmp.text_color[1], cmp.text_color[2], cmp.text_color[3])

  -- cmp.text_size  = imgui.InputInt("text_size", cmp.text_size)
  imgui.Text(RM.fonts[cmp.text_font]:getHeight())
  update_cmp_combo(imgui, cmp, "text_font", "fonts")

  cmp.text = imgui.InputText("text", cmp.text, 128)
end

-------------------------------------------------
-- Multi cmp
-------------------------------------------------

local function animation(cmp_ani, cmp_ren, imgui)
  if imgui.BeginTabItem("animation") then
    if not cmp_ren then imgui.Text("no render") return end
    local sprite = RM.sprites[cmp_ren.sprite]
    if sprite == nil then imgui.Text("No sprite") return end
    local s_w, s_h = sprite:getDimensions()

    cmp_ani.vel = imgui.InputFloat("anim vel", cmp_ani.vel, 0.1)
    cmp_ani.step = imgui.SliderInt("anim step", cmp_ani.step, 0, s_w)

    local v, c = imgui.InputFloat("anim frame", cmp_ani.frame, cmp_ani.step)
    if c then
      if v >= s_w then cmp_ani.frame = 0
      else cmp_ani.frame = v end
    end

    imgui.Separator(50)
    imgui.Text("animation counter: " .. cmp_ani.count)
    imgui.Text("sprite dimensions : " .. s_w .. "x" ..  s_h)
    imgui.Spacing()

    utils.imgui_canvas(imgui, sprite, 1, function()
      love.graphics.draw(sprite)
      love.graphics.setColor(0, 0, 0, 0.6)
      love.graphics.rectangle("fill", cmp_ani.quad:getViewport())
      love.graphics.setColor(1, 1, 1)
      love.graphics.setLineWidth(2)
      love.graphics.rectangle("line", cmp_ani.quad:getViewport())
      love.graphics.reset()
    end)

    imgui.EndTabItem()
  end
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
  if table.has_keys(entity.cmps, {"animation" }) then
    animation(entity.cmps.animation, entity.cmps.render, imgui)
  end
  imgui.EndTabBar()
  imgui.End()
end
