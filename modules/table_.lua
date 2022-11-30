
---Extended table namespace
---

---Checks if table contains given key
---@param t table to ce
---@param element any to check
function table.has_key(t, element)
  if t[element] then return true
  else return false
  end
end

---Checks if table contains given keys
---@param t table
---@param args table containing string keys to check
function table.has_keys(t, args)
  for i = 1, #args do
    local has_key = table.has_key(t, args[i])
    if not has_key then return false end
  end
  return true
end

---Checks if table contains given value
---@param t table to ce
---@param element any to check
function table.has_value(t, element)
  for _, v in pairs(t) do
    if v == element then
      return true
    end
  end
  return false
end

--- Find table inside table list with the following format
--- t1 = { { key = val, ... }, {key = val, ... }, ... }
---
---@param t1 table list of tables
---@param t2_key string key of t2 to check
---@param t2_value any value of t2 to check
function table.get_subtable(t1, t2_key, t2_value)
  for i = 1, #t1 do
    if t1[i][t2_key] and t1[i][t2_key] == t2_value then
      return t1[i]
    end
  end
end

---Counts number of elements in a table
---@param t table
---@param element any to check
function table.count_value(t, element)
  local count = 0
  for _, v in pairs(t) do
    if v == element then
      count = count + 1
    end
  end
  return count
end

---Check if table is empty
---@param t table to check
function table.empty(t)
  if next(t) == nil then return true
  else return false
  end
end

---Shuffles table content
---using math.randomseed(os.time()) so results are always different
---@param t table to shuffle
function table.shuffle(t)
  math.randomseed(os.time())
  for i = #t, 2, -1 do
    local j = math.random(i)
    t[i], t[j] = t[j], t[i]
  end
end

---Retuns key of max number of table
---@param t table to shuffle
function table.max_key(t)
  local key, max = 1, t[1]
  for k, v in ipairs(t) do
    if t[k] > max then
      key, max = k, v
    end
  end
  return key
end

---Returns a copy of a table
---@param t table to copy
function table.copy(t)
  local u = {}
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end

---
---Returns a deep copy of a table
---
---@param t table to copy
function table.deepcopy(t, seen)
    if type(t) ~= 'table' then return t end
    if seen and seen[t] then return seen[t] end

    local s = seen or {}
    local res = {}
    s[t] = res
    for k, v in pairs(t) do
      res[table.deepcopy(k, s)] = table.deepcopy(v, s)
    end
    return setmetatable(res, getmetatable(t))
end

---Returns a read only table
---@param t table to make read only
function table.protect(t)
  return setmetatable({}, {
    __index = t,
    __newindex = function(_, key, value)
      error("attempting to change constant " ..
      tostring(key) .. " to " .. tostring(value), 2)
    end
  })
end

--- Checks if o has fields that t doesnt, in that case
--- raises error
---
---@param o table
---@param t table
---@param level integer stack level
function table.check_invalid_fields(o, t, level)
  for key, _ in pairs(o) do
    if not t[key] then
      error("no field " .. tostring(key), level)
    end
  end
end

---
--- Pretty dump of table
---
---@param t table table to dump
---@param ... string indetation level
---@return string
function table.dump(t, ...)
  local level = ...
  if level == nil then level = "  " end
  if type(t) == 'table' then
    local s = '{\n'
    for k,v in pairs(t) do
      if type(k) == 'number' then
        s = s .. level .. '['.. k ..'] = '
      else
        s = s .. level ..  k .. ' = '
      end
      if type(v) == 'table' then
        s = s .. table.dump(v, level .. "  ")
      else
        s = s .. table.dump(v, level)
      end
      s = s .. ',\n'
    end
    level = string.sub(level, 3, #level)
    return s .. level .. '}'
  elseif type(t) == "string" then
    return '"' .. tostring(t) .. '"'
  else
    return tostring(t)
  end
end

---
--- Delete entry from table by key
---
---@param t table
---@param key string
---@return any deleted value
function table.remove_key(t, key)
  local value = t[key]
  t[key] = nil
  return value
end

---
--- Dump table to file adding return at start
--- to use file as a module
---
---@param t table
---@param path string
function table.write_to_file(t, path)
  local f = io.open(path, "w")
  if f then
    f:write("return ")
    f:write(table.dump(t))
    f:flush()
    f:close()
  end
end

return table
