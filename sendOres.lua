Modem = peripheral.wrap("right")
Me = peripheral.wrap("bottom")
OreNames = {
    {"alltheores:steel_ingot",colors.gray},
    {"minecraft:gold_ingot",colors.yellow},
    {"alltheores:osmium_ingot",colors.lightBlue},
    {"minecraft:iron_ingot",colors.lightGray},
    {"allthemodium:vibranium_ingot",colors.green},
    {"alltheores:tin_ingot",colors.white},
    {"alltheores:aluminum_ingot",colors.lightGray},
    {"silentgear:crimson_iron_ingot",colors.pink},
    {"alltheores:platinum_ingot",colors.cyan},
    {"alltheores:zinc_ingot",colors.lightBlue},
    {"minecraft:copper_ingot",colors.orange},
    {"minecraft:netherite_ingot",colors.gray},
    {"alltheores:lead_ingot",colors.blue},
    {"allthemodium:unobtainium_ingot",colors.magenta},
    {"silentgear:blaze_gold_ingot",colors.orange},
    {"alltheores:nickel_ingot",colors.white},
    {"allthemodium:allthemodium_ingot",colors.orange},
    {"biggerreactors:graphite_ingot",colors.gray},
    {"mekanism:ingot_steel",colors.lightGray},
    {"immersiveengineering:ingot_aluminum",colors.lightGray},
    {"silentgear:crimson_steel_ingot",colors.red},
    {"mekanism:ingot_refined_obsidian",colors.purple},
    {"minecraft:netherite_scrap",colors.gray},
    {"minecraft:lapis_lazuli",colors.blue},
    {"minecraft:diamond",colors.cyan},
    {"minecraft:emerald",colors.lime},
    {"minecraft:redstone",colors.red},
    {"productivebees:draconic_dust",colors.purple},
    {"minecraft:nether_star", colors.white},
    {"alltheores:uranium_ingot", colors.lime},
    {"ae2:certus_quartz_crystal",colos.lightBlue}
}

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
    local channel = 42
    table.sort(ores, compareOres)
    Modem.transmit(channel, channel ,ores)
end

while true do
    sendOres(createOreList())
    sleep(1)
end