
--
-- AI component
--

return function(o)
  -- list of posible ai behaviours
  return {
    step = 1,
    patrol = o.patrol or nil,

    behs = o.behs or {
      move = function() end
    }
  }
end
