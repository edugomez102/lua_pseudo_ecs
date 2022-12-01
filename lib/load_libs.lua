local function add_cpath(path)
  package.cpath = package.cpath .. ";lib/" .. path
end

os.do_for_os(
  function() add_cpath("imgui.so") end,
  function() add_cpath("imgui.dll") end
)

