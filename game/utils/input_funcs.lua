------------
-- Input Funcs
-- Funcs to define input actions
-- TODO add @see
local input_funcs = {}

--- move up
---@param cmp_phy table
function input_funcs.move_up(cmp_phy)
  cmp_phy.vy = -cmp_phy.vel
end

--- move down
---@param cmp_phy table
function input_funcs.move_down(cmp_phy)
  cmp_phy.vy = cmp_phy.vel
end

--- move_right
---@param cmp_phy table
function input_funcs.move_right(cmp_phy)
  cmp_phy.vx = cmp_phy.vel
end

--- move_left
---@param cmp_phy table
function input_funcs.move_left(cmp_phy)
  cmp_phy.vx = -cmp_phy.vel
end

--- reset
---@param cmp_phy table
function input_funcs.reset(cmp_phy)
  cmp_phy.vx = 0
  cmp_phy.vy = 0
end

return input_funcs
