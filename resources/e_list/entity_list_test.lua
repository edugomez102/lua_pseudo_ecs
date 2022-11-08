local CMP = require("cmp.cmp_all")

return {
  {
    type = "test",
    cmps = {
      transform = CMP.transform({}),
      physics   = CMP.physics({vx = 1, vy = 0}),
      render    = CMP.render({w = 40, h = 40})
    }
  },
  {
    type = "test"
  }
}
