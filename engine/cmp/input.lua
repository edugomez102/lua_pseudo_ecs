
--
-- Input component
--

return function(o)
  return {
    keys = o.keys or nil,
    gamepad = o.gamepad or nil,
    mouse = o.mouse or nil,
  }
end
