return {
  {
    type = E_TYPES.player,
    cmps = {
      transform = {
        pos = { x = 100, y = 100 },
      },
      physics = {
        vx = 0,
        vy = 0,
        vel = 5
      },
      render = {
        -- w = 40,
        -- h = 40,
        color = {255, 255, 255},
        sprite = "test"
      },
      input = {
        keys = {
          w = "move_up",
          s = "move_down",
          a = "move_left",
          d = "move_right",
        },
        gamepad = {
          dpup    = "move_up",
          dpdown  = "move_down",
          dpleft  = "move_left",
          dpright = "move_right"
        }
      },
      collision = {
        w = 40,
        h = 40
      }
    }
  },
  {
    type = E_TYPES.enemy,
    cmps = {
      transform = {
        pos = {x = 400 , y = 500}
      },
      physics = {vel = 5},
      render    = {
        w = 55,
        h = 35,
        color = {0, 255, 0},
      },
      collision = {
        beh = "die",
        w = 60,
        h = 40,
      }
    }
  },
  {
    type = E_TYPES.enemy,
    cmps = {
      transform = {
        pos = {
          x = 10, y = 10
        }
      },
      physics = {vel = 5},
      render    = {
        w = 40,
        h = 40,
        color = {0, 255, 0},
        sprite = "test"
      },
      ai = {
        patrol = "patrol_02",
        behs = {
          move = "patrol_move",
        }
      },
      collision = {
        beh = "change_color",
        w = 40,
        h = 40,
      }
    }
  },
  {
    type = E_TYPES.enemy,
    cmps = {
      transform = {
        pos = {x = 200 , y = 500}
      },
      physics = {vel = 5},
      render    = {
        w = 5,
        h = 5,
        color = {0, 255, 0},
      },
      collision = {
        beh = "die",
        w = 60,
        h = 40
      }
    }
  },
}
