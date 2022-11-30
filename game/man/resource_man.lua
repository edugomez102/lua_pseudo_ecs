------------
-- Resource manager.
-- Table containing assets of the game

local new_img = love.graphics.newImage

---
---Load resources from file
---
---@return table
local function load_resources(path)
  local resources = {}
  local handle = os.do_for_os(
    function() return io.popen("ls game/assets/" .. path) end,
    function() return io.popen("dir game\\assets\\" .. path .. " /b /a-d") end
  )
  if handle then
    local result = handle:read("a")
    for line in string.lines(result) do
      local no_extension = line:sub(0, -5)
      resources[no_extension] =
      new_img("game/assets/img/" .. line)
    end
    handle:close()
  end
  return resources
end

---
--- Manager of assets TODO
---
---@table RM
local RM = {
  sprites = load_resources("img"),
  music = {}
}

function RM:reload_resources()
  self.sprites = load_resources("img")
end

return RM
