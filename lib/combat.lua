local combat = {}

function combat.same_group(left, right)
    if left == nil or right == nil then return left == right end
    return left.slot_row == right.slot_row and left.group_index == right.group_index
end

-- Prefer the current group on equal cost so actors keep a valid firing position.
function combat.lowest_cost(event, groups, current)
    local chosen, minimum, current_cost
    for _, group in ipairs(groups) do
        local cost, known = event:task_cost{group = group}
        if not known then return nil, false end
        if cost ~= nil and (minimum == nil or cost < minimum) then
            chosen, minimum = group, cost
        end
        if combat.same_group(group, current) then current_cost = cost end
    end
    if current ~= nil and current_cost ~= nil and current_cost == minimum then
        return current, true
    end
    return chosen, true
end

return combat
