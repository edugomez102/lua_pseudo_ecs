local cmp_transform = {}

function cmp_transform:new()
  return{
    position = {
      x = 0,
      y = 0
    },
    scale = {
      x = 0,
      y = 0
    },
    rotation = {
      x = 0,
      y = 0
    }
  }
end

return cmp_transform
