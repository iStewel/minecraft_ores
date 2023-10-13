function oresTableToJSON(table)
    local JSON = "{\"ores\":["
    local i = 0
    for k,v in pairs(table) do
        if i ~= 0 then
            JSON = JSON .. ","
        end
        
        local amount = v[1] ~= nil and tostring(v[1]) or "null"
        local name = v[2] ~= nil and v[2] or "null"
        local color = v[3] ~= nil and v[3] or "null"

        JSON = JSON .. "{\"amount\":" .. amount .. ", \"name\":\"" .. name .. "\", \"color\":\"" .. color .. "\"}"
        
        i=i+1
    end
    JSON = JSON .. "]}"

    return JSON
    
end
