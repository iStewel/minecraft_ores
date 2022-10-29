Modem = peripheral.wrap("right")
Me = peripheral.wrap("bottom")
OreNames = {{}}

function getColorIfWantedOre(ore)
    local wantedOre = nil

    for k, v in pairs(OreNames) do
        if ore == v[1] then
            wantedOre = v[2]
            break
        end
    end

    return wantedOre
end

function createOreList()
    local meItemList = Me.listItems()
    local index = 1
    local ores = {}

    for k, v in pairs(meItemList) do
        local oreColor = getColorIfWantedOre(v["name"])
        if oreColor ~= nil then
            ores[index] = { v["amount"], v["displayName"], oreColor}
            index = index + 1
        end
    end

    return ores
end

function compareOres(a, b)
    return a[1] > b[1]
end

function sendOres(ores)
    table.sort(ores, compare)
    modem.transmit(channel, channel ,ores)
end

while true do
    sendOres(createOreList())
    sleep(1)
end