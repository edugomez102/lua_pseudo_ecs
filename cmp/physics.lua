--
-- Physics component
--

return function(o)
  return {
    vx = o.vx or 0,
    vy = o.vy or 0,
    vel = o.vel or 1
  }
end
