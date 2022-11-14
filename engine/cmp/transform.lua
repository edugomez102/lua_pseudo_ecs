------------
-- Transform component
--

return function(o)
  local cmp = {
    pos = o.pos or {
      x = 0,
      y = 0
    },
    scale = o.scale or {
      x = 0,
      y = 0
    },
    rotation = o.rotation or {
      x = 0,
      y = 0
    }
  }
  table.check_invalid_fields(o, cmp, 2)
  return cmp
end
