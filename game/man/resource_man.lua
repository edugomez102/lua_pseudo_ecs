---
--- Resource manager
---

local new_img = love.graphics.newImage

local RM = {
  sprites = {
    test = new_img("game/assets/img/sprite_test.png"),
  },
  music = {
  }
}

return RM
