local sys_input = {}

local input_funcs = {}
function sys_input:init(Game)
  input_funcs = Game.utils.input_funcs
end

local function update_one(p_e)
  local cmp_inp = p_e.cmps.input
  local cmp_phy = p_e.cmps.physics
  local active = false

  for key, value in pairs(cmp_inp.keys) do
    if love.keyboard.isDown(key) then
      input_funcs[value](cmp_phy)
      active = true
    end
  end

  -- TODO improve
  if not active then
    input_funcs.reset(cmp_phy)
  end

  -- function love.keypressed(kb)
  --   if table.has_key(cmp_inp.keys, kb) then
  --     input_funcs[cmp_inp.keys[kb]](cmp_phy)
  --     -- cmp_inp.keys[kb](cmp_phy)
  --   end
  -- end
  --

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
