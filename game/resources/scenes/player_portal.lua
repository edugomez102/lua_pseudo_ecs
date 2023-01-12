return {
  editor_info = {
    entity_names = {
    },
    dirty = false,
  },
  entities = {
    [1] = {
      cmps = {
        transform = {
          pos = {
            x = 764,
            y = 328,
          },
          rotation = {
            x = 0,
            y = 0,
          },
          scale = {
            x = 0,
            y = 0,
          },
        },
        animation = {
          step = 60,
          quad = nil,
          margin = 0,
          frame = 60,
          count = 0.017213664,
          vel = 0.09999992698431,
        },
        render = {
          sprite = "spawn_warn_big",
          h = 20,
          w = 20,
          color = {
            [1] = 1,
            [2] = 0.22549021244049,
            [3] = 0.22549021244049,
          },
        },
      },
      id = 1,
      type = 5,
    },
    [2] = {
      cmps = {
        input = {
          keys = {
            a = "move_left",
            d = "move_right",
            s = "move_down",
            w = "move_up",
          },
          gamepad = {
            dpdown = "move_down",
            dpleft = "move_left",
            dpright = "move_right",
            dpup = "move_up",
          },
        },
        physics = {
          vx = 0,
          vy = 0,
          vel = 5,
        },
        transform = {
          pos = {
            x = 425,
            y = 490,
          },
          rotation = {
            x = 0,
            y = 0,
          },
          scale = {
            x = 0,
            y = 0,
          },
        },
        collision = {
          h = 40,
          w = 40,
        },
        render = {
          sprite = "sprite_test",
          h = 40,
          w = 40,
          color = {
            [1] = 255,
            [2] = 255,
            [3] = 255,
          },
        },
      },
      id = 2,
      type = 1,
    },
    [3] = {
      cmps = {
        transform = {
          pos = {
            x = 0,
            y = 0,
          },
          rotation = {
            x = 0,
            y = 0,
          },
          scale = {
            x = 0,
            y = 0,
          },
        },
        render = {
          sprite = "box_back",
          h = 78,
          w = 160,
          color = {
            [1] = 1,
            [2] = 0.99998998641968,
            [3] = 0.99998998641968,
          },
        },
        widget = {
          text_color = {
            [1] = 9.9999999747524e-07,
            [2] = 9.9998999303352e-07,
            [3] = 9.9998999303352e-07,
          },
          hud = true,
          text = "feto",
          w = 126,
          text_font = "PressStart2P",
          h = 70,
        },
      },
      id = 3,
      type = 5,
    },
  },
}
