---
---Extended string namespace
---

---Iterate over a string containing \n
---@param s string
function string.lines(s)
  if s:sub(-1) ~= "\n" then
    s = s.."\n"
  end
  return s:gmatch("(.-)\n")
end

return string
