------------
-- Animtion System
--
local sys_anim = {}
local RM = require("game.man.resource_man")

---
--- Init system.
--- Inits local fields
---
---@param Game table
function sys_anim:init(Game)
end

local function update_one(p_e, dt)
  local cmp_ren = p_e.cmps.render
  local cmp_ani = p_e.cmps.animation
  -- local frame = cmp_ani.frame
  -- local count = cmp_ani.count
  local vel = cmp_ani.vel
  local step = cmp_ani.step
  local sprite_w, sprite_h = RM.sprites[cmp_ren.sprite]:getDimensions()

  cmp_ani.count = cmp_ani.count + 1 * dt
  if cmp_ani.count >= vel * 60 * dt then
    cmp_ani.count = 0
    cmp_ani.frame = cmp_ani.frame + step

    if cmp_ani.frame >= sprite_w then
      cmp_ani.frame = 0
    end
  end

  if not cmp_ani.quad then
    cmp_ani.quad =
    love.graphics.newQuad(cmp_ani.frame, 0, step,
      sprite_h, sprite_w, sprite_h)
  else
    cmp_ani.quad:setViewport(cmp_ani.frame, 0, step,
      sprite_h, sprite_w, sprite_h)
  end
end

---
--- Updates system
---
---@param EM table
function sys_anim.update(EM, dt)
  EM:forall({"transform", "render", "animation"},
  function(entity)
    update_one(entity, dt)
  end)
end

return sys_anim
