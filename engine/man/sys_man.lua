------------
-- System Manager.
-- System of ECS entities.

---
--- System names and order in which they will update
---
---@table sys_index
local sys_index = {
  "render",
  "physics",
  "ai",
  "input",
  "collision",
}

---
--- Load systems from file using sys_index as
--- system order
---
---@return table const table containing systems 
local function load_sys()
  local sys = {}
  for i = 1, #sys_index do
    sys[sys_index[i]] = require("engine.sys." .. sys_index[i])
  end
  return table.protect(sys)
end

---
--- System Manager TODO
---
local SM = {
  systems = load_sys() -- TODO more clear
}

---
---@param Game any
function SM:init(Game)
  for i = 1, #sys_index do
    self.systems[sys_index[i]]:init(Game)
  end
end

---
---@param EM table
function SM:update(EM)
  for i = 1, #sys_index do
    self.systems[sys_index[i]].update(EM)
  end
end

return SM
