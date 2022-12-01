local protected = {}

local function protect(key, value)
    if _G[key] then
        protected[key] = _G[key]
        _G[key] = nil
    else
        protected[key] = value
    end
end

local meta = {
    __index = protected,
    __newindex = function(tbl, key, value)
        if protected[key] then
            error("attempting to overwrite constant " .. tostring(key) .. " to " .. tostring(value), 2)
        end
        rawset(tbl, key, value)
    end
}
setmetatable(_G, meta)

-------------------------------------------------
-- Globals
-------------------------------------------------

-- screen width
_G.S_W = 1920; protect("S_W")
-- screen height
_G.S_H = 1080; protect("S_H")


-- build type
_G.OG_DEBUG = true
if arg[2] == "release" then _G.OG_DEBUG = false end
protect("OG_DEBUG")

