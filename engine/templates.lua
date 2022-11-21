---
--- Contains templtes of entities to create them easily
--- IMPORTANT: use table.deepcopy when using a entity template
---
---@table templates
return {
  basic = {
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
        color = {255, 255, 255 },
        -- sprite = "test"
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
  to_random = {
    type = E_TYPES.enemy,
    cmps = {
      transform = {
        pos = {
          x = math.random(0, 1280),
          y = math.random(0, 720)
        }
      },
      physics = {
        vel = 1
      },
      render    = {
        w = math.random(5, 20),
        h = math.random(5, 20),
        color = {
          -- 255, 0, 0
          math.random(0, 255) / 255,
          math.random(0, 255) / 255,
          math.random(0, 255) / 255,
        },
      },
      collision = {
        w = 10,
        h = 10,
        beh = "die"
      },
      ai = {
        behs = {
          move = "move_to_randon",
          aim = {
            x = math.random(0, 1280),
            y = math.random(0, 720)
          }
        }
      },
    }
  }

}
