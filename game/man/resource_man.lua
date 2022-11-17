------------
-- Resource manager.
-- Table containing assets of the game

local new_img = love.graphics.newImage

---
--- Manager of assets TODO
---
---@table RM
local RM = {
  sprites = {
    test = new_img("game/assets/img/sprite_test.png"),
    spawn = new_img("game/assets/img/spawn_warn_big.png"),
  },
  music = {
  }
}

return RM
