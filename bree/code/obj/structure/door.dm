// BREE~DOOR

/obj/structure/door
	icon = 'bree/icons/obj/structure/door64.dmi'
	icon_state = "wood"
	var/icon_base

	anchored = TRUE
	opacity = TRUE
	density = TRUE

	var/open_layer = OPEN_DOOR_LAYER
	var/closed_layer = CLOSED_DOOR_LAYER

	var/noise

/obj/structure/door/Initialize()
	. = ..()
	if (material)
		color = material.icon_colour

	for(var/direction in GLOB.cardinal)
		var/turf/T = get_step(src, direction)

		if(istype(T, /turf/simulated/wall))
			var/turf/simulated/wall/W = T
			W.update_connections(1)
			W.update_icon()

/obj/structure/door/on_update_icon()
	. = ..()
	layer = density ? closed_layer : open_layer
	icon_state = "[icon_base][!density ? "open" : null]"

/obj/structure/door/attack_hand(mob/user)
	if ((. = ..()))
		return
	if(!CanPhysicallyInteract(user))
		return FALSE

	density = !density
	opacity = density
	update_icon()
	playsound(src.loc, noise, 80, 1)

	return TRUE

/obj/structure/door/yew
	name = "wooden door"
	icon_base = "wood"
	material = /material/wood/yew
	noise = 'sound/effects/doorcreaky.ogg'
