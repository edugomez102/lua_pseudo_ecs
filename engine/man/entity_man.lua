local e = require("engine.man.entity")

---
--- Entity Manager
---
local EM = {
  storage = {},
}

---
--- Create and store entity in EM
---
---@param p_et table template of entity
---@return table entity ref
function EM:create_entity(p_et)
  local new_e = e.new(p_et)
  self.storage[#self.storage + 1] = new_e
  return new_e
end

---
--- Creates entities of given list
--- 
---@param p_entity_list table with list of entities
function EM:init_from_list(p_entity_list)
  for i = 1, #p_entity_list do
    self:create_entity(p_entity_list[i])
  end
end

---
--- Checks for dead entities and removes them from storage
--- Sets value of dead entity to nil and then shifts the storage array
---
function EM:update()
  local stg = self.storage
  local n = #stg

  local j = 1
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
