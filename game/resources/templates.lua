return {
  to_random = {
    type = 2,
    cmps = {
      ai = {
        behs = {
          aim = {
            x = 942,
            y = 307,
          },
          move = "move_to_randon",
        },
      },
      physics = {
        vel = 1,
      },
      transform = {
        pos = {
          x = 1017,
          y = 503,
        },
      },
      render = {
        w = 14,
        h = 17,
        color = {
          [1] = 0.07843137254902,
          [2] = 0.66274509803922,
          [3] = 0.33725490196078,
        },
      },
      collision = {
        w = 10,
        h = 10,
        beh = "die",
      },
    },
  },
  player_01 = {
    type = 1,
    cmps = {
      physics = {
        vx = 0,
        vy = 0,
        vel = 5,
      },
      transform = {
        pos = {
          x = 100,
          y = 100,
        },
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
      input = {
        keys = {
          w = "move_up",
          d = "move_right",
          a = "move_left",
          s = "move_down",
        },
        gamepad = {
          dpdown = "move_down",
          dpleft = "move_left",
          dpright = "move_right",
          dpup = "move_up",
        },
      },
      collision = {
        w = 40,
        h = 40,
      },
    },
  },
  wid_rest = {
    id = 1,
    type = 5,
    cmps = {
      transform = {
        scale = {
          x = 0,
          y = 0,
        },
        rotation = {
          x = 0,
          y = 0,
        },
        pos = {
          x = 486,
          y = 499,
        },
      },
      render = {
        w = 46,
        h = 41,
        color = {
          [1] = 0,
          [2] = 0,
          [3] = 0,
        },
      },
    },
  },
  portal = {
    id = 1,
    type = 5,
    cmps = {
      transform = {
        scale = {
          x = 0,
          y = 0,
        },
        rotation = {
          x = 0,
          y = 0,
        },
        pos = {
          x = 818.33330081569,
          y = 343.33331969049,
        },
      },
      animation = {
        step = 60,
        count = 0.100397157,
        vel = 0.09999992698431,
        margin = 0,
        frame = 120,
      },
      render = {
        sprite = "spawn_warn_big",
        h = 20,
        w = 20,
        color = {
          [1] = 1,
          [2] = 0.99998998641968,
          [3] = 0.99998998641968,
        },
      },
    },
  },
  portal_random = {
    cmps = {
      ai = {
        step = 1,
        behs = {
          move = "move_to_randon",
        },
        aim = {
          x = 327,
          y = 1863,
        },
      },
      physics = {
        vy = 1,
        vx = -1,
        vel = 1,
      },
      transform = {
        scale = {
          x = 0,
          y = 0,
        },
        rotation = {
          x = 0,
          y = 0,
        },
        pos = {
          x = 10,
          y = 10,
        },
      },
      render = {
        sprite = "spawn_warn_big",
        color = {
          [1] = 0.36862745098039,
          [2] = 0.047058823529412,
          [3] = 0.90588235294118,
        },
        w = 20,
        h = 20,
      },
      collision = {
        w = 60,
        h = 80,
      },
      animation = {
        step = 60,
        count = 0.100154817,
        vel = 0.09999992698431,
        margin = 0,
        frame = 120,
      },
    },
    type = 5,
    id = 1,
  },
  aaa = {
    id = 1,
    type = 5,
    cmps = {
      transform = {
        scale = {
          x = 0,
          y = 0,
        },
        rotation = {
          x = 0,
          y = 0,
        },
        pos = {
          x = 0,
          y = 0,
        },
      },
    },
  },
  basic = {
    type = 2,
    cmps = {
      ai = {
        behs = {
          move = "patrol_move",
        },
        patrol = "patrol_02",
      },
      physics = {
        vel = 5,
      },
      transform = {
        pos = {
          x = 10,
          y = 10,
        },
      },
      render = {
        w = 40,
        h = 40,
        color = {
          [1] = 255,
          [2] = 255,
          [3] = 255,
        },
      },
      collision = {
        w = 40,
        h = 40,
        beh = "change_color",
      },
    },
  },
}