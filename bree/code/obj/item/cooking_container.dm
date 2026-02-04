/obj/item/reagent_containers/cooking_pot
	icon = 'icons/obj/cooking_container.dmi'
	icon_state = "pot"
	// var/shortname
	var/place_verb = "into"
	// var/dish = "stew"
	var/max_space = 10
	force = 5
	throw_speed = 1
	throw_range = 5
	volume = 120
	w_class = ITEM_SIZE_NORMAL
	atom_flags = ATOM_FLAG_OPEN_CONTAINER //| ATOM_FLAG_NO_REACT
	matter = list(MATERIAL_ALUMINIUM = 3000)
	var/list/insertable = list(
		/obj/item/reagent_containers/food/snacks
	)
	var/container_type = COOKING_CONTAINER_POT
	// var/cook_type // optional string to influence the appliance cook_type
	var/time = 0

/obj/item/reagent_containers/cooking_pot/use_tool(obj/item/tool, mob/living/user, list/click_params)
	if (is_type_in_list(tool, insertable))
		if (!can_fit(tool))
			to_chat(user, SPAN_WARNING("There's no more space in [src] for that!"))
			return TRUE
		if (!user.unEquip(tool))
			return TRUE
		tool.forceMove(src)
		to_chat(user, SPAN_NOTICE("You put [tool] [place_verb] [src]."))
		update_icon()
		return TRUE

	return ..()

/obj/item/reagent_containers/cooking_pot/proc/calc_w()
	var/w = 0
	for (var/contained in contents)
		var/obj/item/J = contained
		w += J.w_class
	return w

/obj/item/reagent_containers/cooking_pot/proc/can_fit(obj/item/I)
	var/w = calc_w()
	if((max_space - w) >= I.w_class && !I.anchored && I.canremove)
		return TRUE
	return FALSE

/obj/item/reagent_containers/cooking_pot/proc/calc_cooking_time()
	var/w = calc_w()
	w += volume / 3
	return w * 6 SECONDS / SSobj.wait

// /obj/item/reagent_containers/cooking_pot/proc/isEmpty()
// 	return !reagents.total_volume && !contents.len

/obj/item/reagent_containers/cooking_pot/proc/cook()
	for (var/obj/item/reagent_containers/i in contents)
		i.reagents.trans_to_holder(src.reagents, 100)
		contents -= i
		qdel(i)

/obj/item/reagent_containers/cooking_pot/proc/burn()
	playsound(get_turf(src), 'sound/effects/flare.ogg', 75, 1)

/obj/item/reagent_containers/cooking_pot/proc/cooking_tick()
	time -= 1
	if (time <= 0)
		time = 0
		burn()



// /obj/item/reagent_containers/plate
// 	icon = 'icons/obj/cooking_container.dmi'
// 	icon_state = "pot"
// 	force = 5
// 	throw_speed = 1
// 	throw_range = 5
// 	volume = 40
// 	w_class = ITEM_SIZE_NORMAL
// 	atom_flags = ATOM_FLAG_OPEN_CONTAINER | ATOM_FLAG_NO_REACT
// 	matter = list(MATERIAL_ALUMINIUM = 3000)
