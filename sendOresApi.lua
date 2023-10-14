API_URL = ""

Modem = peripheral.wrap("left")
Me = peripheral.wrap("bottom")

Channel = 42

function dataTableToJSON(table)
    local meItemList = Me.listItems()
    local JSON = "{\"data\":["
    local i = 0
    for k,v in pairs(meItemList) do
        if i ~= 0 then
            JSON = JSON .. ","
        end

        JSON = JSON .. "{\"amount\":" .. v["amount"] .. ", \"name\":\"" .. v["name"] .. "\", \"displayName\":\"" .. v["displayName"] .. "\"}"
        
        i = i + 1
    end
    JSON = JSON .. "]}"

    return textutils.urlEncode(JSON)
    
end

function sendApi()
    http.post(API_URL, "data=" .. dataTableToJSON())
end

while true do
    sendApi()
    sleep(10)
end
