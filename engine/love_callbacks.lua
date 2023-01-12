---
--- Runs callbacks of love like love.quit, love.mousemoved etc
---

------------------------------------------------------- DEBUG
if OG_DEBUG then
  return function(input, Editor)

    function love.quit()
      Editor.imgui.ShutDown();
    end

    function love.textinput(t)
      Editor.imgui.TextInput(t)
      -- if not Editor.imgui.GetWantCaptureKeyboard() then
      --     -- Pass event to the game
      -- end
    end

    function love.keypressed(key)
      Editor.imgui.KeyPressed(key)
      -- if not Editor.imgui.GetWantCaptureKeyboard() then
      --     -- Pass event to the game
      -- end
    end

    function love.keyreleased(key)
      Editor.imgui.KeyReleased(key)
      -- if not Editor.imgui.GetWantCaptureKeyboard() then
      --     -- Pass event to the game
      -- end
    end

    function love.mousemoved(x, y)
      Editor.imgui.MouseMoved(x, y)
      -- if not Editor.imgui.GetWantCaptureMouse() then
      --     -- Pass event to the game
      -- end
    end

    function love.mousepressed(x, y, button)
      Editor.imgui.MousePressed(button)
      -- if not Editor.imgui.GetWantCaptureMouse() then
      --     -- Pass event to the game
      -- end
    end

    function love.mousereleased(x, y, button)
      Editor.imgui.MouseReleased(button)
      -- if not Editor.imgui.GetWantCaptureMouse() then
      --     -- Pass event to the game
      -- end
    end

    function love.wheelmoved(x, y)
      Editor.imgui.WheelMoved(y)
      -- if not Editor.imgui.GetWantCaptureMouse() then
      --     -- Pass event to the game
      -- end
    end
  end
else
  return function(input)
  end
end
