-- Copyright (C) 2023 Norbert Thien, multimediamobil - Region Süd, Lizenz: Creative Commons BY-SA 4.0
-- Copyright Media: verwendet Medien (Bilder und Töne) aus dem Ordner games\minetest_game\mods\default 
-- Kein Rezept, nur im Creative Modus verwendbar oder mit give <playername> mesecons_blockwires:wire_NAME_off


-- Töne für verschiedene Materialien
local soundsConfig = function (pMaterial)
	if string.find(pMaterial, "Snow") then
		return default.node_sound_snow_defaults()
	elseif string.find(pMaterial, "Grass") then
		return default.node_sound_leaves_defaults()
	elseif string.find(pMaterial, "Dirt") then
		return default.node_sound_dirt_defaults()
	elseif string.find(pMaterial, "Ice") then
		return default.node_sound_glass_defaults()
	elseif string.find(pMaterial, "Wood") then
		return default.node_sound_wood_defaults()
	elseif string.find(pMaterial, "Default") then --Default Sand
		return default.node_sound_sand_defaults()
	else
		return default.node_sound_stone_defaults()
	end
end

-- Materialien für verschiedene Blöcke
local tilesConfig = function (pName)
	if string.find(pName, "grass") then
		return {"blockwire_grass.png", "blockwire_dirt.png", {name = "blockwire_dirt.png^blockwire_grass_side.png", tileable_vertical = false}}
	elseif string.find(pName, "snow") then
		return {"blockwire_snow.png", "blockwire_dirt.png", {name = "blockwire_dirt.png^blockwire_snow_side.png", tileable_vertical = false}}
	else
		return {"blockwire_" .. pName .. ".png"} -- Standardblöcke mit 6 gleichen Materialseiten
	end
end

-- Materialien im Ordner textures: erster Eintrag Datei(teil)name, zweiter Eintrag description
local blockwires = {
		{"acaciawood", "Acacia Wood"},
		{"aspenwood", "Aspen Wood"},
		{"brickstone", "Brick Stone"},
		{"desertsandstonebrick", "Desert Sandstonebrick"},
		{"desertstonebrick", "Desert Stonebrick"},
		{"dirt", "Dirt"},
		{"grass", "Grass"},
		{"ice", "Ice"},
		{"junglewood", "Jungle Wood"},
		{"pinewood", "Pine Wood"},
		{"sand", "Default Sand"},
		{"sandstone", "Sandstone"},
		{"sandstonebrick", "Sandstonebrick"},
		{"silversandstonebrick", "Silver Sandstonebrick"},
		{"snow", "Snow"},
		{"stonebrick", "Stonebrick"},
		{"stone", "Stone"},
		{"wood", "wood"},
}

-- Schleife, in der die Blöcke zusammengebaut werden
for _, row in ipairs(blockwires) do

	local name = row[1]
	local description = row[2]

minetest.register_node("mesecons_blockwires:wire_" .. name .. "_off", {
	description = "Wire " .. description .. " Block",
	tiles = tilesConfig(name),
	inventory_image = "blockwire_" .. name .. ".png^blockwire_mese.png",
	drop = "mesecons_blockwires:wire_" .. name .. "_off",
	--selection_box = selectionbox,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = soundsConfig(description),
	mesecons = {conductor = {
		state = mesecon.state.off,
		onstate = "mesecons_blockwires:wire_" .. name .. "_on",
		rules = mesecon.rules.alldirs
	}},
	on_blast = mesecon.on_blastnode,
})


minetest.register_node("mesecons_blockwires:wire_" .. name .. "_on", {
	description = "Wire " .. description .. " Block",
	tiles = tilesConfig(name),
	drop = "mesecons_blockwires:wire_" .. name .. "_on",
	--selection_box = selectionbox,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, not_in_creative_inventory = 1},
	sounds = soundsConfig(description),
	mesecons = {conductor = {
		state = mesecon.state.on,
		offstate = "mesecons_blockwires:wire_" .. name .. "_off",
		rules = mesecon.rules.alldirs
	}},
	on_blast = mesecon.on_blastnode,
})

end

-- Glas-Material off
local name = "glass"
local description = "Glass"

minetest.register_node("mesecons_blockwires:wire_" .. name .. "_off", {
	description = "Wire " .. description .. " Block",
	drawtype = "glasslike_framed_optional",
	tiles = {"blockwire_" .. name .. ".png"},
	inventory_image = "blockwire_" .. name .. ".png^blockwire_mese.png",
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = soundsConfig(description),
	mesecons = {conductor = {
		state = mesecon.state.off,
		onstate = "mesecons_blockwires:wire_" .. name .. "_on",
		rules = mesecon.rules.alldirs
	}},
	on_blast = mesecon.on_blastnode,
})

-- Glas-Material on
minetest.register_node("mesecons_blockwires:wire_" .. name .. "_on", {
	description = "Wire " .. description .. " Block",
	drawtype = "glasslike_framed_optional",
	tiles = {"blockwire_" .. name .. ".png"},
	inventory_image = "blockwire_" .. name .. ".png^blockwire_mese.png",
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, not_in_creative_inventory = 1},
	sounds = soundsConfig(description),
	mesecons = {conductor = {
		state = mesecon.state.on,
		offstate = "mesecons_blockwires:wire_" .. name .. "_off",
		rules = mesecon.rules.alldirs
	}},
	on_blast = mesecon.on_blastnode,
})

-- Buschblätter off
local name = "leaves"
local description = "Bush Leaves"

minetest.register_node("mesecons_blockwires:wire_" .. name .. "_off", {
	description = "Wire " .. description .. " Block",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"blockwire_" .. name .. ".png"},
	inventory_image = "blockwire_" .. name .. ".png^blockwire_mese.png",
	paramtype = "light",
	groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	mesecons = {conductor = {
		state = mesecon.state.off,
		onstate = "mesecons_blockwires:wire_" .. name .. "_on",
		rules = mesecon.rules.alldirs
	}},
	on_blast = mesecon.on_blastnode,
})

-- Buschblätter on
minetest.register_node("mesecons_blockwires:wire_" .. name .. "_on", {
	description = "Wire " .. description .. " Block",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"blockwire_" .. name .. ".png"},
	inventory_image = "blockwire_" .. name .. ".png^blockwire_mese.png",
	paramtype = "light",
	groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 3, flammable = 2, leaves = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),
	mesecons = {conductor = {
		state = mesecon.state.on,
		offstate = "mesecons_blockwires:wire_" .. name .. "_off",
		rules = mesecon.rules.alldirs
	}},
	on_blast = mesecon.on_blastnode,
})
