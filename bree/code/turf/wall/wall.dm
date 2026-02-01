/turf/simulated/wall/medieval
	icon = 'bree/icons/turf/wall/wall.dmi'
	var/icon_base

	floor_type = /turf/simulated/floor/land
	var/connections_value = 0

/turf/simulated/wall/medieval/update_material()
	if(!material)
		material = SSmaterials.get_material_by_name(DEFAULT_WALL_MATERIAL)

	explosion_resistance = material.explosion_resistance
	icon_base = material.wall_icon_base

	SetName("[material.adjective_name] [material.wall_name]")
	desc = "A wall built of [material.display_name]."

	set_opacity(material.opacity >= 0.5)
	update_connections(1)
	update_icon()
	calculate_damage_data()

	return

/turf/simulated/wall/medieval/update_connections(propagate = 0)
	connections_value = 0

	for (var/dir in GLOB.cardinal)
		var/turf/T = get_step(src, dir)
		if(!T)
			continue

		if(istype(T, /turf/simulated/wall))
			connections_value += dir
			if(propagate)
				var/turf/simulated/wall/W = T
				W.update_connections()
				W.update_icon()
			continue

/turf/simulated/wall/medieval/on_update_icon()
	update_flood_overlay()
	queue_ao(FALSE)

	ClearOverlays()

	icon_state = "[icon_base][connections_value]"
	if (material)
		color = material.icon_colour

	var/turf/T = get_step(src, NORTH)
	if(!istype(T, /turf/simulated/wall))
		var/image/F = image('bree/icons/turf/wall/frill.dmi', icon_state, pixel_y = 32, layer = ABOVE_HUMAN_LAYER)
		F.color = color
		F.alpha = 160
		AddOverlays(F)
	return

// BREE~code\game\turfs\simulated\wall_attacks.dm
/turf/simulated/wall/use_tool(obj/item/W, mob/living/user, list/click_params)
	var/area/A = get_area(src)
	if (!A.can_modify_area())
		to_chat(user, SPAN_NOTICE("\The [src] deflects all attempts to interact with it!"))
		return TRUE

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)

	if(!construction_stage && try_graffiti(user, W))
		return TRUE

	if (!user.IsAdvancedToolUser())
		to_chat(user, SPAN_WARNING("You don't have the dexterity to do this!"))
		return TRUE

	if(!isturf(user.loc))
		return	..()

	var/heat_value = W.IsHeatSource()
	if (heat_value)
		burn(heat_value)

	// var/turf/T = user.loc	//get user's location for delay checks

	// var/damage = get_damage_value()

	var/cut_delay = 60 - material.cut_delay
	var/dismantle_verb
	var/dismantle_sound
	var/strict_timer_flags = FALSE

	if(istype(W, /obj/item/pickaxe))
		var/obj/item/pickaxe/P = W
		dismantle_verb = P.drill_verb
		dismantle_sound = P.drill_sound
		cut_delay -= P.digspeed
		strict_timer_flags = TRUE

	if(dismantle_verb)
		to_chat(user, SPAN_NOTICE("You begin [dismantle_verb] \the [src]."))
		if(dismantle_sound)
			playsound(src, dismantle_sound, 100, 1)

		if(cut_delay < 0)
			cut_delay = 0


		user.visible_message(SPAN_WARNING("[user] begins to take apart \the [src]!"), SPAN_NOTICE("You begins to take apart \the [src]."))
		if (do_after(user, cut_delay, src, strict_timer_flags ? DO_PUBLIC_UNIQUE : DO_REPAIR_CONSTRUCT))
			dismantle_wall()
			user.visible_message(SPAN_WARNING("[user] took half \the [src] apart!"), SPAN_NOTICE("You took half \the [src] apart."))
		return TRUE

	return ..()

/turf/simulated/wall/dismantle_wall(devastated, no_product)
	playsound(src, 'sound/items/Welder.ogg', 100, 1)
	if(!no_product)
		material.place_sheet(get_turf(src), 4)

	add_hiddenprint(usr)
	var/obj/structure/wall_frame/medieval/L = new(src, material.name)
	L.add_hiddenprint(usr)

	material = SSmaterials.get_material_by_name("placeholder")
	ChangeTurf(floor_type)



/turf/simulated/wall/medieval/wood
	icon_state = "wood"
	icon_base = "wood"

/turf/simulated/wall/medieval/wood/oak/New(newloc)
	..(newloc, MATERIAL_OAK)

/turf/simulated/wall/medieval/wood/beech/New(newloc)
	..(newloc, MATERIAL_BEECH)

/turf/simulated/wall/medieval/wood/birch/New(newloc)
	..(newloc, MATERIAL_BIRCH)

/turf/simulated/wall/medieval/wood/maple/New(newloc)
	..(newloc, MATERIAL_MAPLE)

/turf/simulated/wall/medieval/wood/ash/New(newloc)
	..(newloc, MATERIAL_ASH)

/turf/simulated/wall/medieval/wood/spruce/New(newloc)
	..(newloc, MATERIAL_SPRUCE)

/turf/simulated/wall/medieval/wood/pine/New(newloc)
	..(newloc, MATERIAL_PINE)
