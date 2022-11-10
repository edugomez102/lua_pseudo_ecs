local e = require("engine.man.entity")

local EM = {
  storage = {},
}

-- local function generate_cmps(p_cmp_list)
--   local cmps = {}
--   for key, value in pairs(p_cmp_list) do
--     cmps[key] = CMP[key](value)
--   end
--   return cmps
-- end

function EM:create_entity(p_e)
  self.storage[#self.storage + 1] = p_e
  return p_e
end

--
-- Creates entities of given list index of EM.lists
-- 
--@param e_list_index table with list of entities
function EM:init_from_list(p_entity_list)
  for i = 1, #p_entity_list do
    self:create_entity(e.new(p_entity_list[i]))

    -- TODO improve
    -- local ent = self:create_entity(e.new({}))
    -- ent.cmps = generate_cmps(self.lists[e_list_index][i].cmps)

  end
end

---
--- Checks for dead entities and removes them from storage
--- Sets value of dead entity to nil and then shifts the storage array
---
function EM:update()
  local stg = self.storage
  local j = 1
  local n = #stg

  for i = 1, n do
    if stg[i].type == E_TYPES.dead then
      stg[i] = nil
    else
      if (i ~= j) then
        stg[j] = stg[i]
        stg[i] = nil
      end
      j = j + 1
    end
  end
end

function EM.delete_all()
end

return EM
