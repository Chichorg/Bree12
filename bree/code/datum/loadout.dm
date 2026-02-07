// BREE~LOADOUT
/datum/gear/uniform
	sort_category = "Dress"
	slot = slot_w_uniform
	category = /datum/gear/uniform

/datum/gear/uniform/everyday
	display_name = "everyday wear, color select"
	path = /obj/item/clothing/under/bree/everyday
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/uniform/toga
	display_name = "toga, color select"
	path = /obj/item/clothing/under/bree/toga
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/uniform/pants
	display_name = "pants, color select"
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/uniform/pants/New()
	..()
	var/pants = list()
	pants += /obj/item/clothing/under/bree/pants
	pants += /obj/item/clothing/under/bree/worn_pants
	gear_tweaks += new/datum/gear_tweak/path/specified_types_list(pants)



/datum/gear/suit
	sort_category = "Overwear"
	slot = slot_wear_suit_str
	category = /datum/gear/suit

/datum/gear/suit/cape
	display_name = "cape, color select"
	path = /obj/item/clothing/suit/bree/cape
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/cloak
	display_name = "cloak, color select"
	path = /obj/item/clothing/suit/bree/cloak
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/shawl
	display_name = "shawl, color select"
	path = /obj/item/clothing/suit/bree/shawl
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/small_cloak
	display_name = "small cloak, color select"
	path = /obj/item/clothing/suit/bree/small_cloak
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/robe
	display_name = "robe, color select"
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/robe/New()
	..()
	var/robes = list()
	robes += /obj/item/clothing/suit/bree/robe
	robes += /obj/item/clothing/suit/bree/robe/alt
	gear_tweaks += new/datum/gear_tweak/path/specified_types_list(robes)
