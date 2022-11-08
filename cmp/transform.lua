local cmp_transform = {}

function cmp_transform:new(o)
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

return cmp_transform
