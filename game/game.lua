require("game.entity_types")

local Game = {
  systems = {},
  man     = {},
  utils = {
    input_funcs = require("game.utils.input_funcs")
  },
  beh = {
    ai  = require("game.beh.ai_beh"),
    col = require("game.beh.col_beh")
  },
  levels = {
    level_test = require("game.resources.e_list.entity_list_test"),
    level_01   = {}
  }
}

--- Adds systems of the game to the engine SM
function Game:add_game_sys(SM)
end

--- Adds systems of the game to the engine SM
function Game:add_game_cmp(EM)
end

function Game:init(EM, SM)
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
