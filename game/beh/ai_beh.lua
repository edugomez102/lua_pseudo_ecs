local ai_beh = {}

function ai_beh.move_one(p_e)
  local cmp_phy = p_e.cmps.physics
  cmp_phy.vx = cmp_phy.vel

  if p_e.cmps.transform.pos.x > 500 then
    p_e.cmps.ai.beh = "move_two"
  end
end

function ai_beh.move_two(p_e)
  local cmp_phy = p_e.cmps.physics
  cmp_phy.vx = -cmp_phy.vel

  if p_e.cmps.transform.pos.x < 5 then
    p_e.cmps.ai.beh = "move_one"
  end

end

return ai_beh
