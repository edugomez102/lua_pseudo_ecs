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
        vel = 2
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
      },
      collision = CMP.collision{
      }
    }
  },
  {
    type = "enemy",
    cmps = {
      transform = CMP.transform{},
      physics = CMP.physics{vel = 5},
      render    = CMP.render{
        w = 60,
        h = 40,
        color = {0, 255, 0},
      },
      ai = CMP.ai{
        beh = "move_one"
      },
      collision = CMP.collision{
        beh = "test_one"
      }
    }
  },
  {
    type = "enemy",
    cmps = {
      transform = CMP.transform{
        pos = {
          x = 130, y = 400
        }
      },
      physics = CMP.physics{vel = 3},
      render    = CMP.render{
        w = 40,
        h = 40,
        color = {0, 255, 0},
      },
      ai = CMP.ai{
        beh = "move_one"
      },
      collision = CMP.collision{
        beh = "test_one"
      }
    }
  }
}
