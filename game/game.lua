------------
-- Game.
-- Game manager.
--@see game.entity_types

require("game.entity_types")

-- TODO check OS
local function load_scenes()
  local scene_table = {}
  local handle = os.do_for_os(
    function() return io.popen("ls game/resources/scenes") end,
    function() return io.popen("dir game\\resources\\scenes /b /a-d") end
  )
  if handle then
    local result = handle:read("a")
    for line in string.lines(result) do
      local no_extension = line:sub(0, -5)
      scene_table[no_extension] =
      require("game.resources.scenes." .. no_extension)
    end
    handle:close()
    return scene_table
  end
end

--- TODO
---@table Game
local Game = {
  utils = {
    input_funcs = require("game.utils.input_funcs")
  },
  man     = {
    RM = require("game.man.resource_man")
  },
  beh = {
    ai  = require("game.beh.ai_beh"),
    col = require("game.beh.col_beh")
  },
  current_scene = nil,
  scenes = load_scenes(),
  levels = {
    level_test = require("game.resources.e_list.entity_list_test"),
    level_01   = {}
  }
}

function Game:reload_scenes()
  self.scenes = load_scenes()
end

--- Adds systems of the game to the engine SM
function Game:add_game_sys(SM)
end

--- Adds systems of the game to the engine SM
function Game:add_game_cmp(EM)
end

function Game:init(EM, SM)
end

---@param EM table
---@param p_scene string
function Game:load_scene(EM, p_scene)
  EM:init_from_list(table.deepcopy(self.scenes[p_scene].entities))
  self.current_scene = p_scene
end

---
--- Creates entites for a level
---
---@param EM table
---@param p_level string key of level list
function Game:load_level(EM, p_level)
  EM:init_from_list(self.levels[p_level])
end

return Game
