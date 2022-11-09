---
---Extended table namespace
---

---Checks if table contains given key
---@param t table to ce
---@param element any to check
function table.has_key(t, element)
  for k in pairs(t) do
    if k == element then
      return true
    end
  end
  return false
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

return table
