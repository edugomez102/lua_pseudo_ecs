local utils = require("engine.editor.utils")

local function scene_submenu(Editor, Game, EM)
  local imgui = Editor.imgui
  for key, value in pairs(Game.scenes) do
    if imgui.MenuItem(key) then
      EM:delete_all()
      Game:load_scene(EM, key)
      -- TODO add to default scene
      for key_info in pairs(Editor.info) do
        log(key_info, "key_info")
        if value.editor_info then
          Editor.info[key_info] = value.editor_info[key_info]
        else
          Editor.info[key_info] = {} --TODO check reset ok
        end
      end
    end
  end
end

-- local show_storage_dump = false
local new_scene_name = ""

return function (Editor, EM, SM, Game)
  local imgui = Editor.imgui
  local info  = Editor.info
  -- local show_storage_dump = Editor.bools.show_storage_dump
  if imgui.BeginMainMenuBar() then
    if imgui.BeginMenu("File") then
      if imgui.BeginMenu("Open Scene") then
        scene_submenu(Editor, Game, EM)
      imgui.EndMenu()
      end

      if imgui.MenuItem("Save Scene") then
        if Game.current_scene then
          local path = "game/resources/scenes/" .. Game.current_scene .. ".lua"
          local dump_t = {
            editor_info = info,
            entities = EM.storage
          }
          table.write_to_file(dump_t, path)
          Game:reload_scenes()
        else
          -- TODO overlay error messasge
          -- push overlay
        end
      end

      if imgui.BeginMenu("Save Scene as") then
        new_scene_name =
        imgui.InputText("scene name", new_scene_name, 128)
        if imgui.Button("Save") then
          local path = "game/resources/scenes/" .. new_scene_name .. ".lua"
          local dump_t = {
            editor_info = info,
            entities = EM.storage
          }
          table.write_to_file(dump_t, path)
          Game.current_scene = new_scene_name
          new_scene_name = ""
          Game:reload_scenes()
        end
        imgui.EndMenu()
      end

      imgui.EndMenu()
    end

    if imgui.BeginMenu("View") then
      if imgui.MenuItem("Storage dump", "mini", Editor.bools.show_storage_dump) then
        Editor.bools.show_storage_dump = not Editor.bools.show_storage_dump
      end
      imgui.EndMenu()
    end

    if Game.current_scene then
      imgui.PushStyleColor("ImGuiCol_Text", 0.4, 0.4, 0.1, 1.0)
      imgui.Text(Game.current_scene)
    else
      imgui.PushStyleColor("ImGuiCol_Text", 1, 0.1, 0.1, 1.0)
      imgui.Text("no scene")
    end
    imgui.PopStyleColor()

    utils.help_marker(imgui, "Reduce Scene zoom if cannot move windows")

    imgui.EndMainMenuBar()
  end

end
