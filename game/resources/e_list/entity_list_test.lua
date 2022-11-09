local CMP = require("cmp.cmp_all")

return {
  {
    type = "player",
    cmps = {
      transform = CMP.transform{
        pos = { x = 100, y = 100 },
      },
      physics   = CMP.physics{
        vx = 0,
        vy = 0,
      },
      render    = CMP.render{
        w = 40,
        h = 40,
        color = {255, 0 ,0},
      },
      input     = CMP.input{
        keys = {
          w = "move_up",
          s = "move_down",
          a = "move_left",
          d = "move_right",
        }
      }
    }
  },
  {
    type = "test",
    cmps = {
      transform = CMP.transform{},
      render    = CMP.render{
        w = 60,
        h = 10,
        color = {0, 255, 0},
      }
    }
  }
}
