local sys_input = {}

local input_funcs
function sys_input:init(Game)
  input_funcs = Game.utils.input_funcs
end

-- TODO improve
local joystick = love.joystick.getJoysticks()[1]


-- TODO refactor update keys, joystick etc
local function update_one(p_e)
  local cmp_inp = p_e.cmps.input
  local cmp_phy = p_e.cmps.physics
  local active = false

  -- keyboard
  if cmp_inp.keys then
    for key, value in pairs(cmp_inp.keys) do
      if love.keyboard.isDown(key) then
        input_funcs[value](cmp_phy)
        active = true
      end
    end
  end

  -- gamepad buttons
  if cmp_inp.gamepad and joystick then
    for key, value in pairs(cmp_inp.gamepad) do
      if joystick:isGamepadDown(key) then
        input_funcs[value](cmp_phy)
        active = true
      end
    end
  end

  -- TODO improve
  if not active then
    input_funcs.reset(cmp_phy)
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
