local function merge_table(destination, source)
    if type(destination) ~= 'table' then
        error('You should specify the destination as a table', 2)
    end
    if type(source) ~= 'table' then
        error('You should specify the source as a table', 2)
    end
    for source_key, source_value in pairs(source) do
        if type(source_value) == 'table' and type(destination[source_key]) == 'table' then
            merge_table(destination[source_key], source[source_key])
        else
            destination[source_key] = source_value
        end
    end

    return destination
end

return {
    merge_table = merge_table
}