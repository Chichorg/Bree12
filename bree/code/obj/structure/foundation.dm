/obj/structure/foundation
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock"
	anchored = TRUE
	density = FALSE
	layer = CATWALK_LAYER
	w_class = ITEM_SIZE_NO_CONTAINER
	health_max = 100

/obj/structure/foundation/New(new_loc, materialtype)
	..(new_loc)
	if(!materialtype)
		materialtype = MATERIAL_SANDSTONE
	material = SSmaterials.get_material_by_name(materialtype)

/obj/structure/foundation/use_tool(obj/item/tool, mob/user, list/click_params)
	if(istype(tool, /obj/item/stack/material))
		var/obj/item/stack/material/S = tool
		if(S.get_amount() < 2)
			to_chat(user, SPAN_NOTICE("There isn't enough material here to construct a wall."))

		var/material/M = SSmaterials.get_material_by_name(S.default_type)
		if(!istype(M))
			return TRUE

		add_hiddenprint(usr)

		if(!do_after(user, 4 SECONDS, src, DO_REPAIR_CONSTRUCT) || !S.use(2))
			return TRUE

		var/obj/structure/wall_frame/medieval/L = new(src.loc, M.name)
		L.add_hiddenprint(usr)
		qdel(src)

		return TRUE

	if (istype(tool, /obj/item/pickaxe))
		playsound(src, 'sound/items/Ratchet.ogg', 50, TRUE)
		user.visible_message(SPAN_WARNING("[user] begins to take apart \the [src]!"), SPAN_NOTICE("You begins to take apart \the [src]."))
		if (!user.do_skilled((tool.toolspeed * 6) SECONDS, SKILL_CONSTRUCTION, src, do_flags = DO_REPAIR_CONSTRUCT) || !user.use_sanity_check(src, tool))
			return TRUE
		user.visible_message(SPAN_WARNING("[user] took \the [src] apart!"), SPAN_NOTICE("You took \the [src] apart."))
		material.place_sheet(get_turf(src), 5)
		qdel(src)
		return TRUE

	return ..()
