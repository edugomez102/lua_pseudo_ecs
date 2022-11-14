------------
-- Input component
--

return function(o)
  local cmp = {
    keys = o.keys or nil,
    gamepad = o.gamepad or nil,
    mouse = o.mouse or nil,
  }
  table.check_invalid_fields(o, cmp, 2)
  return cmp
end
