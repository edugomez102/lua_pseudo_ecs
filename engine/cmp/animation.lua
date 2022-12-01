
return function(o)
  local cmp = {
    quad = o.quad or nil,
    vel = o.vel or 1,

    step = o.step or 60,
    count = o.count or 0,
    frame = o.frame or 0,
    margin = o.margin or 0
  }
  table.check_invalid_fields(o, cmp, 2)
  return cmp
end
