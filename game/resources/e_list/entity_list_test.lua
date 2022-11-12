local CMP = require("engine.cmp.cmp_all")

return {
  {
    type = E_TYPES.player,
    cmps = {
      transform = CMP.transform{
        pos = { x = 100, y = 100 },
      },
      physics   = CMP.physics{
        vx = 0,
        vy = 0,
        vel = 5
      },
      render    = CMP.render{
        w = 40,
        h = 40,
        color = {255, 255, 255},
        sprite = "test"
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
    type = E_TYPES.enemy,
    cmps = {
      transform = CMP.transform{
        pos = {x = 400 , y = 500}
      },
      physics = CMP.physics{vel = 5},
      render    = CMP.render{
        w = 60,
        h = 40,
        color = {0, 255, 0},
      },
      collision = CMP.collision{
        beh = "die"
      }
    }
  },
  {
    type = E_TYPES.enemy,
    cmps = {
      transform = CMP.transform{
        pos = {
          x = 10, y = 10
        }
      },
      physics = CMP.physics{vel = 5},
      render    = CMP.render{
        w = 40,
        h = 40,
        color = {0, 255, 0},
      },
      ai = CMP.ai{
        patrol = "patrol_02",
        behs = {
          move = "patrol_move",
        }
      },
      collision = CMP.collision{
        beh = "change_color"
      }
    }
  },
  {
    type = E_TYPES.enemy,
    cmps = {
      transform = CMP.transform{
        pos = {x = 200 , y = 500}
      },
      physics = CMP.physics{vel = 5},
      render    = CMP.render{
        w = 60,
        h = 40,
        color = {0, 255, 0},
      },
      collision = CMP.collision{
        beh = "die"
      }
    }
  },
}
