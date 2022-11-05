local e = {}

local last_id = 0
local function get_next_id()
  last_id = last_id + 1
  return last_id
end


function e.new(o)
  return {
    id = get_next_id(),
    type = o.type or 0,
    cmps = o.cmps or {}
  }
end

return e

--[[ types
  invalid
  dead
--]]

