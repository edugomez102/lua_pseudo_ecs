------------
-- AI component
--

return function(o)
  -- list of posible ai behaviours
  local cmp =  {
    step = 1,
    patrol = o.patrol or nil,

    behs = o.behs or {
      move = function() end
    }
  }
  table.check_invalid_fields(o, cmp, 2)
  return cmp
end
