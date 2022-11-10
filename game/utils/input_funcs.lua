local input_funcs = {}

function input_funcs.move_up(cmp_phy)
  cmp_phy.vy = -cmp_phy.vel
end

function input_funcs.move_down(cmp_phy)
  cmp_phy.vy = cmp_phy.vel
end

function input_funcs.move_right(cmp_phy)
  cmp_phy.vx = cmp_phy.vel
end

function input_funcs.move_left(cmp_phy)
  cmp_phy.vx = -cmp_phy.vel
end

function input_funcs.reset(cmp_phy)
  cmp_phy.vx = 0
  cmp_phy.vy = 0
end

return input_funcs
