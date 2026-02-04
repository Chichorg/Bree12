/obj/structure/cooking
	// icon = ''
	density = TRUE
	anchored = TRUE

	var/lit = FALSE
	var/fuel = 0

	var/lit_light_power = 3
	var/lit_light_range = 5
	light_color = "#ffc27d"

	var/max_containers = 4
	var/list/containers = list()
	var/container_types = COOKING_CONTAINER_POT

/obj/structure/cooking/Initialize()
	. = ..()
	update_fire_light()
	update_icon()

/obj/structure/cooking/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/structure/cooking/on_update_icon()
	. = ..()
	if (lit)
		icon_state = "[initial(icon_state)]-lit"
	else
		icon_state = "[initial(icon_state)]"

/obj/structure/cooking/Process()
	fuel = max(fuel - 1, 0)
	if (fuel <= 0)
		lit = FALSE
	if (!lit)
		update_fire_light()
		update_icon()
		STOP_PROCESSING(SSobj, src)

	for (var/obj/item/reagent_containers/cooking_pot/c in containers)
		if (c.time) c.cooking_tick()

/obj/structure/cooking/use_tool(obj/item/tool, mob/living/user, list/click_params)
	if (istype(tool, /obj/item/stack/material/wood))
		if (fuel >= 20 MINUTES / SSobj.wait)
			to_chat(user, SPAN_NOTICE("There is enough of firewood in \the [src]."))
			return TRUE

		var/obj/item/stack/material/wood/W = tool
		fuel += 4 MINUTES / SSobj.wait
		W.use(1)
		user.visible_message(SPAN_NOTICE("[user] puts [W] into \the [src]."), SPAN_NOTICE("You put [W] into \the [src]."))
		return TRUE

	if (istype(tool, /obj/item/torch))
		var/obj/item/torch/T = tool
		if (lit != T.lit)
			if (!user.do_skilled(5 SECONDS, SKILL_CONSTRUCTION, src) || !user.use_sanity_check(src, tool))
				return TRUE
			if (lit)
				T.light()
			else if (fuel > 100)
				user.visible_message(SPAN_NOTICE("[user] lights a fire in \the [src] with \the [T]."), SPAN_NOTICE("You light a fire in \the [src] with \the [T]."))
				light()
		return TRUE

	if (istype(tool, /obj/item/reagent_containers/cooking_pot))
		var/obj/item/reagent_containers/cooking_pot/C = tool
		if (max_containers <= containers.len)
			to_chat()
			return TRUE
		if (C.container_type & container_types)
			insert_container(C, user)
		return TRUE

	return ..()

/obj/structure/cooking/attack_hand(mob/user)
	if (use_check_and_message(user))
		return

	var/list/menuoptions = list()
	for (var/obj/item/c in containers)
		var/current_iteration_len = length(menuoptions) + 1
		c.pixel_x = 0
		c.pixel_y = 0
		menuoptions["[c] [current_iteration_len]"] = c

	var/selection = show_radial_menu(user, src, menuoptions, require_near = TRUE, tooltips = TRUE, no_repeat_close = TRUE)
	if (selection)
		var/obj/item/c = menuoptions[selection]

		containers -= c
		if (!user || !user.put_in_hands(c))
			c.forceMove(get_turf(src))
		update_icon()
		return TRUE

	return ..()

/obj/structure/cooking/proc/insert_container(obj/item/reagent_containers/cooking_pot/container, mob/living/user)
	if(!user.unEquip(container))
		return

	container.forceMove(src)
	containers.Add(container)
	container.time = container.calc_cooking_time()
	container.cook()

/obj/structure/cooking/proc/light()
	if (fuel > 100)
		lit = TRUE
		update_icon()
		update_fire_light()
		START_PROCESSING(SSobj, src)
		src.visible_message(SPAN_WARNING("\The [src] flares up."))

/obj/structure/cooking/proc/update_fire_light()
	if (lit)
		set_light(lit_light_power, lit_light_power, light_color)
	else
		set_light(0)




/obj/structure/cooking/oven

/obj/structure/cooking/hearth
