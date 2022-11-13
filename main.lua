require("modules.table_")

local Game = require("game.game")
local EM   = require("engine.man.entity_man")
local SM   = require("engine.man.sys_man")

function love.load()
  SM:init(Game)
  Game:load_level(EM, "level_test")
  for _ = 1, 12000 do
    math.randomseed(os.clock() * 100000000000)
    EM:create_entity{
      type = E_TYPES.enemy,
      cmps = {
        transform = CMP.transform{
          pos = {
            x = math.random(0, 1280),
            y = math.random(0, 720)
          }
        },
        physics = CMP.physics{
          vel = 1
        },
        render    = CMP.render{
          w = math.random(5, 20),
          h = math.random(5, 20),
          color = {
            -- 255, 0, 0
            math.random(0, 255) / 255,
            math.random(0, 255) / 255,
            math.random(0, 255) / 255,
          },
        },
        collision = CMP.collision{
          w = 10,
          h = 10,
          beh = "die"
        },
        ai = CMP.ai{
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
  end
end

-- TODO variable game framerate
function love.update(dt)
  print("framerate:" .. dt * 3600, "storage size:" .. #EM.storage)
  -- print("framerate:" .. dt * 3600)
  EM:update()
  SM:update(EM.storage, dt)

  -- if count == 20 then return end
  -- math.randomseed(os.time())
  -- Game:load_level(EM, "list2")
end

