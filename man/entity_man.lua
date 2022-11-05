local e = require("man.entity")

EM = {
  storage = {}
}

function EM:create_entity(p_e)
  self.storage[#self.storage + 1] = p_e
end

function EM.delete_entity()
end

function EM.entity_set_for_destroy()
end

function EM.init()
end

function EM.update()
end

return EM
