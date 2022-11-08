local CMP = require("cmp.cmp_all")

return {
  {
    type = "test",
    cmps = {
      transform = CMP.transform({}),
      physics   = CMP.physics({vx = 1, vy = 1}),
      render    = CMP.render({})
    }
  },
  {
    type = "nocmp"
  }
}
