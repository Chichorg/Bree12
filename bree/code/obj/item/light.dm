/obj/item/torch
	name = "torch"
	desc = ""
	w_class = ITEM_SIZE_NORMAL
	icon = 'bree/icons/obj/item/light.dmi'
	icon_state = "torch"
	item_state = "torch"
	var/lit = FALSE
	var/fuel = 0
	var/min_fuel = 4 MINUTES
	var/max_fuel = 5 MINUTES
	var/on_damage = 7
	// var/produce_heat = 1500
	var/activation_sound = 'sound/effects/flare.ogg'

	var/lit_light_power = 2
	var/lit_light_range = 4
	light_color = "#ffc27d"


/obj/item/torch/Initialize()
	. = ..()

	update_torch_light()
	fuel = rand(min_fuel, max_fuel) / SSobj.wait
	update_icon()

/obj/item/torch/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/torch/Process()
	// if(produce_heat)
	// 	var/turf/T = get_turf(src)
	// 	if(T)
	// 		T.hotspot_expose(produce_heat)
	fuel = max(fuel - 1, 0)
	if (fuel <= 0)
		lit = FALSE
	if(!lit)
		update_damage()
		update_torch_light()
		update_icon()
		STOP_PROCESSING(SSobj, src)

/obj/item/torch/use_after(obj/O, mob/living/user)
	if (istype(O, /obj/item/torch))
		var/obj/item/torch/T = O
		if (lit != T.lit)
			if (lit)
				T.light()
			else
				light()
		return TRUE

	if (istype(O) && lit)
		O.HandleObjectHeating(src, user, 500)
		return TRUE
	return ..()

/obj/item/torch/proc/light()
	if (lit)
		return

	playsound(get_turf(src), activation_sound, 75, 1)

	if (fuel > 300 / SSobj.wait)
		lit = TRUE
		update_damage()
		update_torch_light()
		update_icon()
		START_PROCESSING(SSobj, src)
		src.visible_message(SPAN_WARNING("\The [src] flares up."))
	else
		src.visible_message(SPAN_WARNING("\The [src] burns out completely."))
		new /obj/decal/cleanable/ash(get_turf(src))
		qdel(src)

/obj/item/torch/proc/update_damage()
	if(lit)
		force = on_damage
		damtype = DAMAGE_BURN
	else
		force = initial(force)
		damtype = initial(damtype)

/obj/item/torch/on_update_icon()
	if (lit)
		icon_state = "[initial(icon_state)]-lit"
		name = "lit [initial(name)]"
	else if (fuel <= 0)
		icon_state = "[initial(icon_state)]-burned"
		name = "burnt-out [initial(name)]"
	else
		icon_state = "[initial(icon_state)]"
		name = initial(name)

/obj/item/torch/proc/update_torch_light()
	if (lit)
		set_light(lit_light_power, lit_light_power, light_color)
	else
		set_light(0)
