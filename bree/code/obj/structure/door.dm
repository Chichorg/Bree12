/obj/structure/door
	name = "wooden door"
	icon = 'bree/icons/obj/structure/doors.dmi'
	icon_state = "wood"
	pixel_x = -16
	var/icon_base = "wood"

	anchored = TRUE
	opacity = TRUE
	density = TRUE

	var/open_layer
	var/closed_layer

	var/noise = 'sound/effects/doorcreaky.ogg'

/obj/structure/door/New(newloc, material_key)
	material = SSmaterials.get_material_by_name(material_key)
	..(newloc)

/obj/structure/door/Initialize()
	. = ..()
	if (material)
		color = material.icon_colour
	if (dir < 3) // north or south
		open_layer = ABOVE_HUMAN_LAYER
		closed_layer = ABOVE_HUMAN_LAYER
	else
		open_layer = OPEN_DOOR_LAYER
		closed_layer = CLOSED_DOOR_LAYER

	update_icon()

/obj/structure/door/on_update_icon()
	. = ..()
	layer = density ? closed_layer : open_layer
	icon_state = "[icon_base][!density ? "open" : null]"

/obj/structure/door/attack_hand(mob/user)
	if ((. = ..()))
		return
	if (!CanPhysicallyInteract(user))
		return FALSE

	if (density)
		open()
	else
		for (var/atom/I in src.loc)
			if (I.density)
				if (I != src)
					user.visible_message(
						SPAN_NOTICE("\The [user] unsuccessfully attempts to close \the [src]."),
						SPAN_NOTICE("You tries to close \the [src], but something is preventing from doing so.")
					)
					return
		close()

	return TRUE

/obj/structure/door/Bumped(atom/AM)
	if (density && ismob(AM))
		open()
	return

/obj/structure/door/proc/open()
	density = FALSE
	opacity = FALSE
	update_icon()
	playsound(src.loc, noise, 80, 1)

/obj/structure/door/proc/close()
	density = TRUE
	opacity = TRUE
	update_icon()
	playsound(src.loc, noise, 80, 1)







/obj/structure/door/oak/New(newloc)
	..(newloc, MATERIAL_OAK)

/obj/structure/door/beech/New(newloc)
	..(newloc, MATERIAL_BEECH)

/obj/structure/door/birch/New(newloc)
	..(newloc, MATERIAL_BIRCH)

/obj/structure/door/maple/New(newloc)
	..(newloc, MATERIAL_MAPLE)

/obj/structure/door/ash/New(newloc)
	..(newloc, MATERIAL_ASH)

/obj/structure/door/spruce/New(newloc)
	..(newloc, MATERIAL_SPRUCE)

/obj/structure/door/pine/New(newloc)
	..(newloc, MATERIAL_PINE)
