---
---Extended os namespace
---

---Check if running in unix or windors
---@return string os win or unix
function os.check_os()
  return package.config:sub(1,1) == "\\" and "win" or "unix"
end

---Runs a fun checking os
---@param fun_unix function for unix system
---@param fun_win function for win system
---@return any
function os.do_for_os(fun_unix, fun_win)
  if os.check_os() == "unix" then
    return fun_unix()
  elseif os.check_os() == "win" then
    return fun_win()
  else error("no OS found") end
end

return os
