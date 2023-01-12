return {
  entities = {
    [1] = {
      cmps = {
        render = {
          h = 20,
          sprite = "spawn_warn_big",
          w = 20,
          color = {
            [1] = 1,
            [2] = 0.22549021244049,
            [3] = 0.22549021244049,
          },
        },
        transform = {
          rotation = {
            x = 0,
            y = 0,
          },
          scale = {
            x = 0,
            y = 0,
          },
          pos = {
            x = 764.99996960163,
            y = 321.66665388478,
          },
        },
        animation = {
          quad = nil,
          margin = 0,
          count = 0.033285668999994,
          frame = 0,
          vel = 0.09999992698431,
          step = 60,
        },
      },
      id = 1,
      type = 5,
    },
    [2] = {
      cmps = {
        physics = {
          vel = 5,
          vx = 0,
          vy = 0,
        },
        input = {
          gamepad = {
            dpright = "move_right",
            dpup = "move_up",
            dpdown = "move_down",
            dpleft = "move_left",
          },
          keys = {
            s = "move_down",
            a = "move_left",
            w = "move_up",
            d = "move_right",
          },
        },
        collision = {
          h = 40,
          w = 40,
        },
        render = {
          h = 40,
          sprite = "sprite_test",
          w = 40,
          color = {
            [1] = 1,
            [2] = 0.99998998641968,
            [3] = 0.99998998641968,
          },
        },
        transform = {
          rotation = {
            x = 0,
            y = 0,
          },
          scale = {
            x = 0,
            y = 0,
          },
          pos = {
            x = 540,
            y = 355,
          },
        },
      },
      id = 2,
      type = 1,
    },
    [3] = {
      cmps = {
        physics = {
          vel = 5,
          vx = -5,
          vy = 0,
        },
        collision = {
          h = 40,
          w = 40,
          beh = "change_color",
        },
        render = {
          h = 40,
          sprite = "skull",
          w = 40,
          color = {
            [1] = 255,
            [2] = 255,
            [3] = 255,
          },
        },
        transform = {
          rotation = {
            x = 0,
            y = 0,
          },
          scale = {
            x = 0,
            y = 0,
          },
          pos = {
            x = 35,
            y = 660,
          },
        },
        ai = {
          aim = {
            x = 0,
            y = 660,
          },
          behs = {
            move = "patrol_move",
          },
          step = 4,
          patrol = "patrol_02",
        },
      },
      id = 5,
      type = 2,
    },
  },
  editor_info = {
    dirty = false,
    entity_names = {
    },
  },
}
