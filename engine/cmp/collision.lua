
--
-- Collision component
--

return function(o)
  return {
    w = o.w or 0,
    h = o.h or 0,
    beh = o.beh or function()
    end
  }
end
