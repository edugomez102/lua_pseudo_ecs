------------funcs
-- Editor funcs
--
local editor_funcs = {
  style  = {},
  window = {},
}

local imgui
local info
function editor_funcs.init(p_imgui, p_info)
  imgui = p_imgui
  info = p_info
end

local RM  = require("game.man.resource_man")

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
editor_funcs.main_dockspace = require("engine.editor.containers.dockspace")

-------------------------------------------------
-- Menu bar
-------------------------------------------------
editor_funcs.main_menu = require("engine.editor.containers.main_menu")

-------------------------------------------------
-- Scene window
-------------------------------------------------
editor_funcs.scene_window = require("engine.editor.containers.scene_win")

-------------------------------------------------
-- Log window
-------------------------------------------------
editor_funcs.log_window = require("engine.editor.containers.log_win")

-------------------------------------------------
-- Entity edit
-------------------------------------------------
local entity_right_click = require("engine.editor.entity.right_click")
local entity_preview_selec = require("engine.editor.entity.preview")

-------------------------------------------------
-- Windows common
-------------------------------------------------



-------------------------------------------------

-- local num = 1.0
local selection = { false, false}
local entity_names = {}
local list_multi_select = false

local nodes = {
  false, false, true, true
}
local node_clicked = -1

local function get_entity_names(EM)
  local entity_names = {}
  for i = 1, #EM.storage do local e = EM.storage[i]
    local has_name = false
    for key, name in pairs(info.entity_names) do
      if key  == e.id then
        entity_names[#entity_names+1] = "ID: " .. e.id .. "  " .. name
        has_name = true
      end
    end
    if not has_name then
      entity_names[#entity_names+1] = "ID: " .. e.id
    end
  end
  return entity_names
end

function editor_funcs.window.editor(EM, SM, bools)
  imgui.Begin("Entity list")
  list_multi_select = imgui.Checkbox("multi select", list_multi_select)
  imgui.SameLine()
  if imgui.Button("new empty") then
    EM:create_entity({ type =  5 })
  end

  -- if EM.storage[num] == nil then return end
  imgui.Separator()
  imgui.Text("Total: " .. #EM.storage)
  imgui.SameLine()
  imgui.Text("Selected ID: " .. bools.num)
  -- info.entity_names[EM.storage[num].id] =
  -- imgui.InputText("Name", info.entity_names[EM.storage[num].id], 128)
  imgui.Separator()

  entity_names = get_entity_names(EM)
  -- for i = 1, #EM.storage do local e = EM.storage[i]
  --   local has_name = false
  --   for key, name in pairs(info.entity_names) do
  --     if key  == e.id then
  --       entity_names[#entity_names+1] = "  name: " .. name .. " ID: " .. e.id
  --       has_name = true
  --     end
  --   end
  --   if not has_name then
  --     entity_names[#entity_names+1] = "  num: " .. i .. " type:" .. e.type .. "    ID: " .. e.id
  --   end
  -- end

--   function()
--     if list_multi_select then
--     return num == i
--   else
--     return selection[i]
--   end
-- end,

  -- imgui.PushStyleColor("ImGuiCol_Text", 0, 0, 1, 1)
  -- imgui.PopStyleColor()

  imgui.PushStyleColor("ImGuiCol_Header", 0.8, 1, 0.4, 0.3)
  for i = 1, #EM.storage do local e = EM.storage[i]
    if not list_multi_select and imgui.Selectable(entity_names[i],
      bools.num == i,
      -- selection[i],
      "ImGuiSelectableFlags_AllowDoubleClick") then
      if imgui.IsMouseDoubleClicked(0) then
        print("doble")
        selection[i] = not selection[i]
      end
      bools.num = i
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
      entity_preview_selec(imgui, EM.storage[i], RM)
      imgui.EndTooltip()
    end
    -- if(imgui.Selectable("id " .. i .. " type:" .. e.type, num == i)) then
    -- end

    if imgui.BeginPopupContextItem() then
      entity_right_click(imgui, e, EM, info, RM)
      imgui.EndPopup()
    end
  end
  imgui.PopStyleColor()

  if imgui.BeginPopup("entity_selection_popup") then
    imgui.Text("popup")
    imgui.EndPopup()
  end

  -- imgui.Separator()
  -- if imgui.TreeNode("entiy types 1") then
  --   imgui.TreePop()
  -- end
  -- if imgui.TreeNode("entiy types 2") then
  --   imgui.TreePop()
  -- end

  -- asociar id de entidad a string
  --   string nombre
  --   id o key con mombre d grupo tree para agrupar


  -- if nodes == true, is leaf
  -- for i = 1, #nodes do
  --   local node_open =  imgui.TreeNode("nodo " .. i, i)
  --   if nodes[i] then
  --     if imgui.IsItemClicked() then
  --       node_clicked = i
  --     end
  --     if node_open then
  --       imgui.Bullet("no")
  --       imgui.TreePop()
  --     end
  --   end
  -- end


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

local entity_editor = require("engine.editor.entity_editor")
function editor_funcs.window.entity_editor(EM, SM, bools)
  entity_editor(EM, SM, imgui, bools.num)
end

function editor_funcs.window.nono(EM, SM, bools)
  imgui.Begin("SM test")
  imgui.Text(table.dump(SM))
  imgui.End()
end

function editor_funcs.window.dump(EM, SM, bools)
  imgui.Begin("entity dump")
  local entity = EM.storage[bools.num]
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
    imgui.Text(table.dump(EM.storage[bools.num]))
    imgui.TreePop()
  end
  imgui.End()
end

function editor_funcs.window.storage_dump(EM, SM, bools)
  if bools.show_storage_dump then
    bools.show_storage_dump = imgui.Begin("Storage dump", bools.show_storage_dump)
    imgui.Separator()
    for i = 1, #EM.storage do
      imgui.Text(i .. ": " ..  table.dump(EM.storage[i]))
      imgui.Separator()
    end
    imgui.End()
  end
end

local rm_canvas = love.graphics.newCanvas(100, 100)
local rm_size = 40
-- local path_str = ""
-- local sprite_key = ""
function editor_funcs.window.rm()
  imgui.Begin("Resource Manager")
  -- rm_size = imgui.SliderInt("rm_size", rm_size, 5, 50)
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
  bools.render_patrol = imgui.Checkbox("render_patrol", bools.render_patrol)
  if imgui.Button("new player") then
    EM:create_entity(table.deepcopy(templates.player_01))
  end
  if imgui.Button("new patrol") then
    EM:create_entity(table.deepcopy(templates.basic))
  end
  -- log(templates, "templates")
  if imgui.Button("add 100 random") then
    for _ = 1, 100 do
      local e = EM:create_entity(table.deepcopy(templates.to_random))
      math.randomseed(os.clock() * 100000000000)
      -- TODO improve
      e.cmps.transform.pos = {
        x = math.random(0, 1920),
        y = math.random(0, 1080)
      }
    end
  end
  imgui.End()
end

return editor_funcs
