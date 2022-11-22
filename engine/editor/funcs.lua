------------
-- Editor funcs
--
local editor_funcs = {
  style  = {},
  window = {},
}
local imgui
function editor_funcs.init(p_imgui)
  imgui = p_imgui
end

local RM  = require("game.man.resource_man")
local CMP = require("engine.cmp.cmp_all")

-------------------------------------------------
-- Style
-------------------------------------------------

function editor_funcs.style.push_basic()
  imgui.PushStyleVar("ImGuiStyleVar_WindowRounding", 0);
  imgui.PushStyleVar("ImGuiStyleVar_WindowBorderSize", 1);
end

function editor_funcs.style.pop_basic()
  imgui.PopStyleVar()
  imgui.PopStyleVar()
end

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

-- local render_fun = require("engine.sys.render").update_one
local function entity_preview_selec(p_e)
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
        if cmp_ren.sprite then
          love.graphics.draw(RM.sprites[cmp_ren.sprite], 0, 0)
        end
        love.graphics.reset()
    love.graphics.setCanvas()
    imgui.Image(pv_canvas, 80, 80)
  end
end

---@param p_e table entity
---@param choose_from table with keys to choose from
---@param fun function
local function cmp_submenu(p_e, choose_from, fun)
  for key, _ in pairs(choose_from) do
    if imgui.MenuItem(key) then
      fun(p_e, key)
    end
  end
end

local function entity_right_click(e, EM)
  entity_preview_selec(e)
  imgui.Separator()
  imgui.Text("entity id: " .. e.id)

  if imgui.MenuItem("Copy entity") then
    EM.copy_entity(table.deepcopy(e))
  end
  if imgui.BeginMenu("Add cmp") then
    cmp_submenu(e, CMP , EM.add_cmp)
    imgui.EndMenu()
  end
  if imgui.BeginMenu("Delete cmp") then
    cmp_submenu(e, e.cmps, EM.delete_cmp)
    imgui.EndMenu()
  end
  if imgui.MenuItem("Delete entity") then
    e.type = E_TYPES.dead
  end
end

---
--- Create DockSpace to which all windws will dock
---
function editor_funcs.main_dockspace()
  imgui.SetNextWindowPos(0, 0)
  imgui.SetNextWindowSize(1280, 720)
  imgui.Begin("DockSpace " .. dockspace_id , true, dockwindow_flaggs)
  imgui.DockSpace(dockspace_id, 0, 0, dockspace_flags)
  imgui.End()
end

-------------------------------------------------
-- Windows
-------------------------------------------------

local entity_agrupation = {}

local num = 1.0
local entity_editor = require("engine.editor.entity_editor")
local selection = { false, false}
local entity_names = {}
local list_multi_select = false

function editor_funcs.window.editor(EM, SM)
  imgui.Begin("Entity list")
  list_multi_select = imgui.Checkbox("multi select", list_multi_select)

  imgui.Separator()
  imgui.Text("Total: " .. #EM.storage .. "  Selected: " .. num)
  imgui.Separator()

  entity_names = {}
  for i = 1, #EM.storage do local e = EM.storage[i]
    entity_names[#entity_names+1] = "  num: " .. i .. " type:" .. e.type .. "    ID: " .. e.id
  end

--   function()
--     if list_multi_select then
--     return num == i
--   else
--     return selection[i]
--   end
-- end,

  -- imgui.PushStyleColor("ImGuiCol_Text", 0, 0, 1, 1)
  -- imgui.PopStyleColor()

  for i = 1, #EM.storage do local e = EM.storage[i]
    if not list_multi_select and imgui.Selectable(entity_names[i],
      num == i,
      -- selection[i],
      "ImGuiSelectableFlags_AllowDoubleClick") then
      if imgui.IsMouseDoubleClicked(0) then
        print("doble")
        selection[i] = not selection[i]
      end
      num = i
    end

    if list_multi_select and imgui.Selectable(entity_names[i],
      -- num == i,
      selection[i],
      "ImGuiSelectableFlags_AllowDoubleClick") then
      selection[i] = not selection[i]
      -- num = i
    end

    ---
    if (imgui.IsItemHovered()) then
      imgui.BeginTooltip()
      entity_preview_selec(EM.storage[i])
      imgui.EndTooltip()
    end
    -- if(imgui.Selectable("id " .. i .. " type:" .. e.type, num == i)) then
    -- end

    if (imgui.BeginPopupContextItem()) then
      entity_right_click(e, EM)
      imgui.EndPopup()
    end
  end

  if imgui.BeginPopup("entity_selection_popup") then
    imgui.Text("popup")
    imgui.EndPopup()
  end

  imgui.Separator()
  if imgui.TreeNode("entiy types 1") then
    imgui.TreePop()
  end
  if imgui.TreeNode("entiy types 2") then
    imgui.TreePop()
  end

  imgui.Separator()


  -- static int selection_mask = (1 << 2); // Dumb representation of what may be user-side selection state. You may carry selection state inside or outside your objects in whatever format you see fit.
  -- int node_clicked = -1;                // Temporary storage of what node we have clicked to process selection at the end of the loop. May be a pointer to your own node type, etc.
  -- for (int i = 0; i < 6; i++)
  -- {
  --     // Disable the default open on single-click behavior and pass in Selected flag according to our selection state.
  --     ImGuiTreeNodeFlags node_flags = base_flags;
  --     const bool is_selected = (selection_mask & (1 << i)) != 0;
  --     if (is_selected)
  --         node_flags |= ImGuiTreeNodeFlags_Selected;
  --     if (i < 3)
  --     {
  --         // Items 0..2 are Tree Node
  --         bool node_open = ImGui::TreeNodeEx((void*)(intptr_t)i, node_flags, "Selectable Node %d", i);
  --         if (ImGui::IsItemClicked())
  --             node_clicked = i;
  --         if (node_open)
  --         {
  --             ImGui::BulletText("Blah blah\nBlah Blah");
  --             ImGui::TreePop();
  --         }
  --     }
  --     else
  --     {
  --         // Items 3..5 are Tree Leaves
  --         // The only reason we use TreeNode at all is to allow selection of the leaf.
  --         // Otherwise we can use BulletText() or advance the cursor by GetTreeNodeToLabelSpacing() and call Text().
  --         node_flags |= ImGuiTreeNodeFlags_Leaf | ImGuiTreeNodeFlags_NoTreePushOnOpen; // ImGuiTreeNodeFlags_Bullet
  --         ImGui::TreeNodeEx((void*)(intptr_t)i, node_flags, "Selectable Leaf %d", i);
  --         if (ImGui::IsItemClicked())
  --             node_clicked = i;
  --     }
  -- }
  -- if (node_clicked != -1)
  -- {
  --     // Update selection state. Process outside of tree loop to avoid visual inconsistencies during the clicking-frame.
  --     if (ImGui::GetIO().KeyCtrl)
  --         selection_mask ^= (1 << node_clicked);          // CTRL+click to toggle
  --     else //if (!(selection_mask & (1 << node_clicked))) // Depending on selection behavior you want, this commented bit preserve selection when clicking on item that is part of the selection
  --         selection_mask = (1 << node_clicked);           // Click to single-select
  -- }
  -- if (align_label_with_current_x_position)
  --     ImGui::Indent(ImGui::GetTreeNodeToLabelSpacing());
  -- ImGui::TreePop();
  --

  imgui.End()
end

function editor_funcs.window.entity_editor(EM, SM, bools)
  entity_editor(EM, SM, imgui, num)
end

function editor_funcs.window.nono(EM, SM, bools)
  imgui.Begin("SM test")
  imgui.Text(table.dump(SM))
  imgui.End()
end

function editor_funcs.window.dump(EM, SM, bools)
  imgui.Begin("entity dump")
  local entity = EM.storage[num]
  if entity == nil then return end
  imgui.Text("ID: " .. entity.id)
  imgui.Text("type: " .. entity.type)
  for key, value in pairs(entity.cmps) do
    if imgui.TreeNode("entity cmp " .. key) then
      imgui.Text(table.dump(value))
      imgui.TreePop()
    end
  end
  imgui.Separator()
  if imgui.TreeNode("Full entity dump") then
    imgui.Text(table.dump(EM.storage[num]))
    imgui.TreePop()
  end
  imgui.End()

  imgui.Begin("Storage dump")
  imgui.Separator()
  for i = 1, #EM.storage do
    imgui.Text(i .. ": " ..  table.dump(EM.storage[i]))
    imgui.Separator()
  end
  imgui.End()
end

local scene_factor = 0.65 -- TODO improve
function editor_funcs.scene_window(canvas)
  imgui.Begin("Scene", false , "HorizontalScrollbar")
  scene_factor = imgui.SliderFloat("Zoom", scene_factor, 0, 10)
  imgui.SameLine()
  if imgui.Button("Reset Zoom") then scene_factor = 0.65 end
  imgui.BeginChild("game_scene")
  imgui.Image(canvas, 1280 * scene_factor, 720 * scene_factor)
  imgui.EndChild()

  imgui.End()
end

-- TODO improve
local RM = require("game.man.resource_man")

local rm_canvas = love.graphics.newCanvas(100, 100)
local rm_size = 40
-- local path_str = ""
-- local sprite_key = ""
function editor_funcs.window.rm()
  imgui.Begin("Resource Manager")
  rm_size = imgui.SliderInt("rm_size", rm_size, 5, 50)
  -- path_str = imgui.InputText("path", path_str, 128)
  -- sprite_key = imgui.InputText("key", sprite_key, 128)
  -- if(imgui.Button("Load Sprite")) then
  --   RM.sprites[sprite_key] = love.graphics.newImage(path_str)
  -- end
  for key, value in pairs(RM.sprites) do
    rm_canvas = love.graphics.newCanvas(100, 100)
    love.graphics.setCanvas(rm_canvas)
      -- love.graphics.clear(0, 0, 0) TODO ???
      love.graphics.draw(value)
    love.graphics.setCanvas()

    imgui.BeginGroup()
    imgui.Bullet()
    imgui.Image(rm_canvas, rm_size , rm_size)
    imgui.SameLine()
    imgui.Text(key)
    imgui.EndGroup()
    if (imgui.IsItemHovered()) then
      imgui.BeginTooltip()
      imgui.Image(rm_canvas, 300, 300)
      imgui.EndTooltip()
    end
  end

  imgui.End()
end

-- TODO better entity creation

local templates = require("engine.templates")
function editor_funcs.window.create(EM, SM, bools)

  imgui.Begin("Tools")
  bools.render_collider = imgui.Checkbox("render_collider", bools.render_collider)
  if imgui.Button("new from t") then
    EM:create_entity(table.deepcopy(templates.basic))
  end
  if imgui.Button("new empty") then
    EM:create_entity({
      type =  5
    })
  end

  if imgui.Button("add 100") then
    for _ = 1, 100 do
      local e = EM:create_entity(table.deepcopy(templates.to_random))
      math.randomseed(os.clock() * 100000000000)
      -- TODO improve
      e.cmps.transform.pos = {
        x = math.random(0, 1280),
        y = math.random(0, 720)
      }
    end
  end
  imgui.End()
end


return editor_funcs
