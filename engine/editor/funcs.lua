------------
-- editor funcs
--
local editor_funcs = {
  window = {}
}
local imgui
function editor_funcs.init(p_imgui)
  imgui = p_imgui
end

local num = 1.0

function editor_funcs.window.test(EM, SM)
  imgui.Begin("si hombr")
  num = imgui.SliderInt("SliderInt", num, 1, #EM.storage);

  imgui.Text(table.dump(EM.storage[num]))
  imgui.End()
end

function editor_funcs.window.hola(EM, SM)
  imgui.Begin("Create")
  if imgui.Button("new") then
    EM:create_entity{
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
      }
  end
  imgui.End()
end

return editor_funcs

