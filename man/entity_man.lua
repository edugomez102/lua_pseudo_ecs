local e = require("man.entity")

EM = {
  storage = {},
  -- TODO check
  lists = {
    test = require("resources.e_list..entity_list_test"),
  }
}

function EM:create_entity(p_e)
  self.storage[#self.storage + 1] = p_e
end

--
-- Creates entities of given list index of EM.lists
-- 
function EM:init_from_list(e_list_index)
  for i = 1, #self.lists[e_list_index] do
    self:create_entity(e.new(self.lists[e_list_index][i]))
    print(i)
  end
end

function EM:update()
  -- check to delete
end

function EM.delete_entity()
end

function EM.delete_all()
end

function EM.entity_set_for_destroy()
end

return EM
