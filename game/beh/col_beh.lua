local col_beh = {}

-- detroy entity on collision
function col_beh.test_one(p_e)
  -- print("col_beh test_one")
  -- p_e.cmps.render.color = {100, 230, 0}
  p_e.type = E_TYPES.dead
end

return col_beh
