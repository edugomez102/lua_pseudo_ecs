------------
-- Physics component
--

return function(o)
  local cmp = {
    vx = o.vx or 0,
    vy = o.vy or 0,
    vel = o.vel or 1
  }
  table.check_invalid_fields(o, cmp, 2)
  return cmp
end
