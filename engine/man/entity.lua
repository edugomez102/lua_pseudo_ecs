------------
-- Entity
--
local e = {}

--- integer last id of created entity
local last_id = 0

--- 
--- Returns entity next id
--- 
---@return integer
local function get_next_id()
  last_id = last_id + 1
  return last_id
end

---
--- Create entity
---
---@param o table entity template
function e.new(o)
  return {
    id = get_next_id(),
    type = o.type or 0,
    cmps = o.cmps or {}
  }
end

return e
