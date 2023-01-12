------------
-- Widget component
--

return function(o)
  local cmp =  {
    text = o.text or nil,
    text_color = o.text_color or {1,1,1},
    text_font = o.text_font or "opensans",
    -- text_size = 10 or nil, TODO

    w = o.w or 200,
    h = o.h or 200,

    hud = o.hud or nil,

  }
  table.check_invalid_fields(o, cmp, 2)
  return cmp
end

