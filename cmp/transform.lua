
--
-- Transform component
--

return function(o)
  return{
    position = o.position or {
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
end
