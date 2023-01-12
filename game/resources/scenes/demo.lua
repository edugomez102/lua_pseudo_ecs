return {
  entities = {
    [1] = {
      type = 5,
      id = 1,
      cmps = {
        render = {
          sprite = "alien",
          color = {
            [1] = 0.65685683488846,
            [2] = 0.65686273574829,
            [3] = 0.65685617923737,
          },
          w = 65,
          h = 69,
        },
        transform = {
          scale = {
            y = 0,
            x = 0,
          },
          pos = {
            y = 479,
            x = 416,
          },
          rotation = {
            y = 0,
            x = 0,
          },
        },
      },
    },
    [2] = {
      type = 5,
      id = 2,
      cmps = {
        transform = {
          scale = {
            y = 0,
            x = 0,
          },
          pos = {
            y = 728,
            x = 1441,
          },
          rotation = {
            y = 0,
            x = 0,
          },
        },
        render = {
          sprite = "heart",
          color = {
            [1] = 0.72156864404678,
            [2] = 0.35686275362968,
            [3] = 0.89803922176361,
          },
          w = 60,
          h = 24,
        },
      },
    },
    [3] = {
      type = 1,
      id = 3,
      cmps = {
        render = {
          sprite = "test",
          color = {
            [1] = 255,
            [2] = 255,
            [3] = 255,
          },
          w = 40,
          h = 40,
        },
        input = {
          gamepad = {
            dpdown = "move_down",
            dpleft = "move_left",
            dpright = "move_right",
            dpup = "move_up",
          },
          keys = {
            d = "move_right",
            a = "move_left",
            w = "move_up",
            s = "move_down",
          },
        },
        collision = {
          w = 40,
          h = 40,
        },
        physics = {
          vx = 0,
          vel = 5,
          vy = 0,
        },
        transform = {
          scale = {
            y = 0,
            x = 0,
          },
          pos = {
            y = 234,
            x = 579,
          },
          rotation = {
            y = 0,
            x = 0,
          },
        },
      },
    },
  },
  editor_info = {
    dirty = false,
    entity_names = {
      [1] = "test",
      [2] = "eee",
      [3] = "new player",
    },
  },
}