return {
  ["to_random"] = {
    ["cmps"] = {
      ["collision"] = {
        ["beh"] = "die",
        ["w"] = 10,
        ["h"] = 10,
      },
      ["physics"] = {
        ["vel"] = 1,
      },
      ["render"] = {
        ["w"] = 14,
        ["color"] = {
          [1] = 0.07843137254902,
          [2] = 0.66274509803922,
          [3] = 0.33725490196078,
        },
        ["h"] = 17,
      },
      ["transform"] = {
        ["pos"] = {
          ["y"] = 503,
          ["x"] = 1017,
        },
      },
      ["ai"] = {
        ["behs"] = {
          ["move"] = "move_to_randon",
          ["aim"] = {
            ["y"] = 307,
            ["x"] = 942,
          },
        },
      },
    },
    ["type"] = 2,
  },
  ["basic"] = {
    ["cmps"] = {
      ["collision"] = {
        ["beh"] = "change_color",
        ["h"] = 40,
        ["w"] = 40,
      },
      ["ai"] = {
        ["behs"] = {
          ["move"] = "patrol_move",
        },
        ["patrol"] = "patrol_02",
      },
      ["render"] = {
        ["w"] = 40,
        ["color"] = {
          [1] = 255,
          [2] = 255,
          [3] = 255,
        },
        ["h"] = 40,
      },
      ["transform"] = {
        ["pos"] = {
          ["y"] = 10,
          ["x"] = 10,
        },
      },
      ["physics"] = {
        ["vel"] = 5,
      },
    },
    ["type"] = 2,
