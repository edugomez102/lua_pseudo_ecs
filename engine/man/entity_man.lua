------------
-- Entity Manager.
-- Manager of ECS entities
--@see engine.man.entity

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
  if raw_cmps == nil then return end
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

-------------------------------------------------
-- Static funcs
-------------------------------------------------

---
--- Removes cmp from an entity and returns it
---
---@param p_e table
---@param cmp_str string cmp name
---@return table removed cmp
---@raise when cmp_str is not in p_e
function EM.delete_cmp(p_e, cmp_str)
  if table.has_key(p_e.cmps, cmp_str) then
    return table.remove_key(p_e.cmps, cmp_str)
  else
    error("no cmp " .. cmp_str .. " in entity with id " .. p_e.id, 2)
  end
end

---
--- Adds component to entity using default cmp constructor
---
---@param p_e table
---@param cmp_str string component name
function EM.add_cmp(p_e, cmp_str)
  if CMP[cmp_str] then
    if not table.has_key(p_e.cmps, cmp_str) then
      p_e.cmps[cmp_str] = CMP[cmp_str]({})
    end
  else
    error("no cmp " .. cmp_str, 2)
  end
end

---
--- Copy entity
---
---@param p_e_to_copy table entity to copy
---@return table created entity
function EM.copy_entity(p_e_to_copy)
  return EM:create_entity(p_e_to_copy)
end

function EM.delete_all()
end

return EM
