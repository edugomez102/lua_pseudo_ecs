
--
-- Render component
--

return function(o)
  local cmp = {
    w = o.w or 0,
    h = o.h or 0,
    color = o.color or { 0, 0, 0 },
    sprite = o.sprite or nil
  }
  table.check_invalid_fields(o, cmp, 2)
  return cmp
end
