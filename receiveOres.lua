Monitor = peripheral.wrap("back")
MonX, MonY = Monitor.getSize()

Channel = 42

function getHumanReadableAmount(amount)
    local humanReadable = amount

    if amount > 1000 then
        humanReadable = (math.floor(amount / 100)/10) .. "k"
    end

    if amount > 1000000 then
        humanReadable = (math.floor(amount / 100000)/10) .. "M"
    end

    return humanReadable
end

function displayToMonitor(ores)
    local rowIndex = 3

    for k, v in pairs(ores) do
        Monitor.setCursorPos(1, rowIndex)
        Monitor.setTextColor(v[3])
        Monitor.write(v[2])

        local oreAmount = getHumanReadableAmount(v[1])
        Monitor.setCursorPos(MonX - string.len(oreAmount) + 1, rowIndex)
        Monitor.write(oreAmount)

        rowIndex = rowIndex + 1
    end
end

function centerText(text)
    return math.floor(math.floor(MonX - string.len(text)) / 2)
end

function clearMonitor()
    Monitor.clear()

    local title = "Ores"
    Monitor.setTextColor(colors.pink)
    Monitor.setCursorPos(centerText(title) + 1, 1)
    Monitor.write(title)
end

function receiveOres()
    local modem = peripheral.wrap("right")
    modem.open(Channel)

    local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")

    if message ~= nil then
        displayToMonitor(message)
    end
end

while true do
    receiveOres()
    sleep(1)
    clearMonitor()
end