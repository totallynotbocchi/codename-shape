local TableUtils = {}

-- returns true if the value is present and its index
function TableUtils.contains(t, v)
  for k, tv in pairs(t) do
    if tv == v then return true, k end
  end

  return false, nil
end

return TableUtils
