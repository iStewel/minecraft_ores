Modem = peripheral.wrap("right")
Channel = 42

Me = peripheral.wrap("bottom")

OreNames = {
    {"alltheores:steel_ingot",colors.gray,"mysticalagriculture:steel_essence",0.375,0},
    {"minecraft:gold_ingot",colors.yellow,"mysticalagriculture:gold_essence",0.5,0},
    {"alltheores:osmium_ingot",colors.lightBlue,"mysticalagriculture:osmium_essence",0.5,0},
    {"minecraft:iron_ingot",colors.lightGray,"mysticalagriculture:iron_essence", 0.75,0},
    {"allthemodium:vibranium_ingot",colors.green,"mysticalagriculture:vibranium_essence", 0.0139,0},
    {"alltheores:tin_ingot",colors.white,"mysticalagriculture:tin_essence", 0.5,0},
    {"alltheores:aluminum_ingot",colors.lightGray,"mysticalagriculture:aluminum_essence", 1,0},
    {"silentgear:crimson_iron_ingot",colors.pink,"mysticalagriculture:crimson_iron_essence", 0.75,0},
    {"alltheores:platinum_ingot",colors.cyan,"mysticalagriculture:platinum_essence", 0.25,0},
    {"alltheores:zinc_ingot",colors.lightBlue,"mysticalagriculture:zinc_essence", 0.5,0},
    {"minecraft:copper_ingot",colors.orange,"mysticalagriculture:copper_essence", 0.75,0},
    {"minecraft:netherite_ingot",colors.gray,"mysticalagriculture:netherite_essence", 0.125,0},
    {"alltheores:lead_ingot",colors.blue,"mysticalagriculture:lead_essence", 0.5,0},
    {"allthemodium:unobtainium_ingot",colors.magenta,"mysticalagriculture:unobtainium_essence", 0.0139,0},
    {"silentgear:blaze_gold_ingot",colors.orange,"",nil,0},
    {"alltheores:nickel_ingot",colors.white,"mysticalagriculture:nickel_essence", 0.5,0},
    {"allthemodium:allthemodium_ingot",colors.orange,"mysticalagriculture:allthemodium_essence", 0.0139,0},
    {"biggerreactors:graphite_ingot",colors.gray,"mysticalagriculture:graphite_essence", 0.625,0},
    {"mekanism:ingot_steel",colors.lightGray,"",nil,0},
    {"immersiveengineering:ingot_aluminum",colors.lightGray,"",nil,0},
    {"silentgear:crimson_steel_ingot",colors.red,"",nil,0},
    {"mekanism:ingot_refined_obsidian",colors.purple,"mysticalagriculture:refined_obsidian_essence", 0.25,0},
    {"minecraft:netherite_scrap",colors.gray,"",nil,0},
    {"minecraft:lapis_lazuli",colors.blue,"mysticalagriculture:lapis_lazuli_essence", 1.5,0},
    {"minecraft:diamond",colors.cyan,"mysticalagriculture:diamond_essence", 0.111,0},
    {"minecraft:emerald",colors.lime,"mysticalagriculture:emerald_essence", 0.111,0},
    {"minecraft:redstone",colors.red,"mysticalagriculture:redstone_essence", 1.5,0},
    {"productivebees:draconic_dust",colors.purple,"", nil,0},
    {"minecraft:nether_star", colors.white,"mysticalagriculture:nether_star_essence", 0.037,0},
    {"alltheores:uranium_ingot", colors.lime,"mysticalagriculture:uranium_essence", 0.25,0},
    {"ae2:certus_quartz_crystal",colors.lightBlue,"mysticalagriculture:certus_quartz_essence", 0.75,0},
    {"minecraft:quartz",colors.white,"mysticalagriculture:nether_quartz_essence", 1.5,0},
    {"ae2:fluix_crystal", colors.purple,"mysticalagriculture:fluix_essence", 0.75,0}
}

function getWantedOre(ore)
    local wantedOre = nil
    for k, v in pairs(OreNames) do
        if ore == v[1] then
            wantedOre = v
            break
        end
    end

    return wantedOre
end

function getWantedEssence(essence)
    local wantedEssence = nil
    for k, v in pairs(OreNames) do
        if essence == v[3] then
            wantedEssence = k
            break
        end
    end

    return wantedEssence
end

function generateEssenceAmounts(itemList)
    for k ,v in pairs(itemList) do
        local essence = getWantedEssence(v["name"])
        if essence ~= nil then
            local multiplier = OreNames[essence][4]

            OreNames[essence][5] = math.floor(v["amount"] * multiplier)
        end
    end
end

function createOreList()
    local meItemList = Me.listItems()
    local index = 1
    local ores = {}

    generateEssenceAmounts(meItemList)

    for k, v in pairs(meItemList) do
        local ore = getWantedOre(v["name"])
        if ore ~= nil then
            local amount = v["amount"]
            if ore[4] ~= nil then
                amount = amount + ore[5]
            end
            ores[index] = { amount, v["displayName"], ore[2]}
            index = index + 1
        end
    end

    return ores
end

function compareOres(a, b)
    return a[1] > b[1]
end

function sendOres(ores)
    table.sort(ores, compareOres)
    Modem.transmit(Channel, Channel ,ores)
end

while true do
    sendOres(createOreList())
    sleep(1)
end