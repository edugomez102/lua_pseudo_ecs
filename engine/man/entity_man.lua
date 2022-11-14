local e = require("engine.man.entity")
local CMP = require("engine.cmp.cmp_all")

---
--- Entity Manager
---
local EM = {
  storage = {},
}


---
--- Generates the cmps field of an entity template using the CMP 
--- constructors to generate default values or delete unused ones
---
---@param raw_cmps table raw cmps list 
---@raise when cmps doesnt exist
local function generate_cmps(raw_cmps)
  for key, value in pairs(raw_cmps) do
    if CMP[key] then
      raw_cmps[key] = CMP[key](value)
    else
      error("no CMP with name " .. tostring(key))
    end
  end
end

---
--- Create and store entity in EM
---
---@param p_et table template of entity
---@return table entity ref
function EM:create_entity(p_et)
  generate_cmps(p_et.cmps)
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
