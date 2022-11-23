
-- TODO make only read outside log.lua
_G.log_list = {}

-- TODO var name auto
-- print(debug.getfenv(debug_info.func))
function _G.log(to_log, var_name)
  local debug_info = debug.getinfo(2)

  local new_info = {
    debug_info = debug_info,
    value = to_log,
  }
  log_list[var_name] = new_info
end
