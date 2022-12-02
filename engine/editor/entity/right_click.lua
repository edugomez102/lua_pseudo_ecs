local CMP = require("engine.cmp.cmp_all")
local utils = require("engine.editor.utils")
local entity_preview_selec = require("engine.editor.entity.preview")

local function not_added_cmps(p_e)
  local t = {}
  for key, _ in pairs(CMP) do
    if not table.has_key(p_e.cmps, key)  then
      t[key] = 0 -- value not used in cmp_submenu
    end
  end
  return t
end

---@param p_e table entity
---@param choose_from table with keys to choose from
---@param fun function
local function cmp_submenu(imgui, p_e, choose_from, fun)
  for key, _ in pairs(choose_from) do
    if imgui.MenuItem(key) then
      fun(p_e, key)
    end
  end
end

local temp_str  = ""
return function (imgui, p_e, EM, info, RM)
  entity_preview_selec(imgui, p_e, RM)

  imgui.Separator()
  -- if imgui.MenuItem("New empty entity") then
  --   EM:create_entity({ type =  5 })
  -- end
  -- imgui.Text("entity id: " .. p_e.id)

  if imgui.MenuItem("Copy entity") then
    EM.copy_entity(table.deepcopy(p_e))
  end
  imgui.Separator()
  if imgui.BeginMenu("CMP add") then
    cmp_submenu(imgui, p_e, not_added_cmps(p_e) , EM.add_cmp)
    imgui.EndMenu()
  end
  if imgui.BeginMenu("CMP delete") then
    cmp_submenu(imgui, p_e, p_e.cmps, EM.delete_cmp)
    imgui.EndMenu()
  end
  imgui.Separator()
  imgui.PushStyleColor("ImGuiCol_Text", 0.7, 0.3, 0.3, 1)
  if imgui.MenuItem("Delete entity") then
    p_e.type = E_TYPES.dead
  end
  imgui.PopStyleColor()
  if imgui.BeginMenu("Make template") then
    local templates = require("game.resources.templates")
    temp_str = imgui.InputText("key", temp_str, 128)
    imgui.SameLine()
    if imgui.Button("Make templte ##btn") then
      templates[temp_str] = p_e
      table.write_to_file(templates, "game/resources/templates.lua")
      temp_str = ""
    end
    imgui.EndMenu()
  end
  -- TODO aaaaaaaaa
  if imgui.BeginMenu("Change name") then
    utils.help_marker(imgui, "Selection widget resets on change so there is no name preview");
    temp_str =
    imgui.InputText("name", temp_str , 128)
    if imgui.Button("Confirm") then
      info.entity_names[p_e.id] = temp_str
      temp_str = ""
    end
    imgui.EndMenu()
  end
end
