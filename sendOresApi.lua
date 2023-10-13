API_URL = ""

Modem = peripheral.wrap("right")
Channel = 42

function oresTableToJSON(table)
    local JSON = "{ores: ["
    for k,v in pairs(table) do
        local amount = v[1] ~= nil and tostring(v[1]) or "null"
        local name = v[2] ~= nil and v[2] or "null"
        local color = v[3] ~= nil and v[3] or "null"

        JSON = JSON .. "{amount:" .. amount .. ", name:" .. name .. ", color:" .. color .. "},"
    end
    JSON = JSON .. "]}"
    
end

function sendApi(ores)
    http.post(API_URL, oresTableToJSON(ores))
end

function centerText(text)
    return math.floor(math.floor(MonX - string.len(text)) / 2)
end

function receiveOres()
    Modem.open(Channel)

    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")

    if message ~= nil then
        sendApi(message)
    end
end

while true do
    receiveOres()
    sleep(1)
end