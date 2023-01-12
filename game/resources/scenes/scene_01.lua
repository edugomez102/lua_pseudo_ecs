return {
  editor_info = {
    entity_names = {
      [1] = "player blar",
      [2] = "tets enemy name",
    },
  },
  entities = {
    [1] = {
      cmps = {
        transform = {
          scale = {
            y = 0,
            x = 0,
          },
          pos = {
            y = 433,
            x = 671,
          },
          rotation = {
            y = 0,
            x = 0,
          },
        },
        physics = {
          vx = 0,
          vel = 5,
          vy = 0,
        },
        collision = {
          w = 40,
          h = 40,
          beh = "change_color",
        },
        input = {
          gamepad = {
            dpup = "move_up",
            dpdown = "move_down",
            dpleft = "move_left",
            dpright = "move_right",
          },
          keys = {
            w = "move_up",
            a = "move_left",
            d = "move_right",
            s = "move_down",
          },
        },
        render = {
          w = 40,
          h = 40,
          sprite = "sprite_test",
          color = {
            [1] = 255,
            [2] = 255,
            [3] = 255,
          },
        },
      },
      id = 1,
      type = 1,
    },
    [2] = {
      cmps = {
        transform = {
          scale = {
            y = 0,
            x = 0,
          },
          pos = {
            y = 385,
            x = 0,
          },
          rotation = {
            y = 0,
            x = 0,
          },
        },
        physics = {
          vx = 0,
          vel = 5,
          vy = -5,
        },
        ai = {
          aim = {
            y = 0,
            x = 0,
          },
          patrol = "patrol_02",
          step = 1,
          behs = {
            move = "patrol_move",
          },
        },
        collision = {
          w = 76,
          h = 105,
          beh = "change_color",
        },
        render = {
          w = 28,
          h = 27,
          sprite = "heart",
          color = {
            [1] = 0.058823529630899,
            [2] = 0.80784314870834,
            [3] = 0.45490196347237,
          },
        },
      },
      id = 2,
      type = 2,
    },
    [3] = {
      cmps = {
        transform = {
          scale = {
            y = 0,
            x = 0,
          },
          pos = {
            y = 436.66664931509,
            x = 948.33329564995,
          },
          rotation = {
            y = 0,
            x = 0,
          },
        },
        animation = {
          frame = 71,
          margin = 69,
        },
        render = {
          w = 52,
          h = 59,
          color = {
            [1] = 0,
            [2] = 0,
            [3] = 0,
          },
        },
      },
      id = 3,
      type = 5,
    },
  },
}
