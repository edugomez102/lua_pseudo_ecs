local sys_input = {}
local input_funcs = require("game.input_funcs")

function sys_input:init()
end

local function update_one(p_e)
  local cmp_inp = p_e.cmps.input
  local cmp_phy = p_e.cmps.physics

  function love.keypressed(kb)
    if table.has_key(cmp_inp.keys, kb) then
      input_funcs[cmp_inp.keys[kb]](cmp_phy)
      -- cmp_inp.keys[kb](cmp_phy)
    end
  end

  -- TODO improve
  function love.keyreleased(kb)
    if table.has_key(cmp_inp.keys, kb) then
      input_funcs.reset(cmp_phy)
    end
  end
end

function sys_input.update(storage)
  for _, entity in pairs(storage) do
    if table.has_key(entity.cmps, "transform") and
       table.has_key(entity.cmps, "input"  ) then

       update_one(entity)
     end
  end
end

return sys_input
