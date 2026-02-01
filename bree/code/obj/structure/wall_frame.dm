/obj/structure/wall_frame/medieval
	icon = 'bree/icons/obj/structure/low_wall.dmi'
	icon_state = "wood0"
	var/icon_base = "wood"

	var/connections_value = 0

/obj/structure/wall_frame/medieval/New

/obj/structure/wall_frame/medieval/on_update_icon()
	if (!icon_base)
		icon_base = material.wall_icon_base

	icon_state = "[icon_base][connections_value]"
	if (material)
		color = material.icon_colour

/obj/structure/wall_frame/medieval/update_connections(propagate = 0)
	connections_value = 0

	for (var/dir in GLOB.cardinal)
		var/turf/T = get_step(src, dir)
		if(!T)
			continue

		for (var/obj/structure/wall_frame/medieval/W in T)
			connections_value += dir
			if(propagate)
				W.update_connections()
				W.update_icon()
			break

// BREE~code\game\objects\structures\wall_frame.dm
/obj/structure/wall_frame/medieval/use_tool(obj/item/tool, mob/user, list/click_params)
	if(istype(tool, /obj/item/stack/material))
		var/obj/item/stack/material/S = tool
		var/material/M = SSmaterials.get_material_by_name(S.default_type)

		if(M == material)
			add_hiddenprint(usr)
			if(!do_after(user, 6 SECONDS, src, DO_REPAIR_CONSTRUCT) || !S.use(2))
				return TRUE

			var/turf/Tsrc = get_turf(src)
			Tsrc.ChangeTurf(/turf/simulated/wall/medieval)
			var/turf/simulated/wall/medieval/T = get_turf(src)
			T.set_material(M, null)

			T.add_hiddenprint(usr)
			qdel(src)

	if (istype(tool, /obj/item/pickaxe))
		playsound(src, 'sound/items/Ratchet.ogg', 50, TRUE)
		user.visible_message(SPAN_WARNING("[user] begins to take apart \the [src]!"), SPAN_NOTICE("You begins to take apart \the [src]."))
		if (!user.do_skilled((tool.toolspeed * 4) SECONDS, SKILL_CONSTRUCTION, src, do_flags = DO_REPAIR_CONSTRUCT) || !user.use_sanity_check(src, tool))
			return TRUE
		user.visible_message(SPAN_WARNING("[user] took \the [src] apart!"), SPAN_NOTICE("You took \the [src] apart."))
		dismantle()
		return TRUE

	return ..()

/obj/structure/wall_frame/medieval/dismantle()
	material.place_sheet(get_turf(src), 4)
	new/obj/structure/foundation(src.loc)
	qdel(src)
