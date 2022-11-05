local cmp_physics = {}

function cmp_physics:new(o)
  return {
    vx = o.vx or 0,
    vy = o.vy or 0,
  }
end

return cmp_physics
