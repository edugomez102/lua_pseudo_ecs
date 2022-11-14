
--
-- Collision component
--

return function(o)
  local cmp = {
    w = o.w or 0,
    h = o.h or 0,
    beh = o.beh or function()
    end
  }
  table.check_invalid_fields(o, cmp, 2)
  return cmp
end
