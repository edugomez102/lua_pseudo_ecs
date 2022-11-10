local col_beh = {}

-- detroy entity on collision
function col_beh.die(p_e)
  p_e.type = E_TYPES.dead
end

function col_beh.change_color(p_e)
  p_e.cmps.render.color = {100, 230, 0}
end

return col_beh
