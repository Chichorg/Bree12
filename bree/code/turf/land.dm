/turf/simulated/floor/land
	name = "land"
	icon = 'icons/turf/jungle.dmi'
	icon_state = "greygrass"
	color = "#799c4b"

	ambient_light_multiplier = 1

	footstep_type = /singleton/footsteps/grass
	has_resources = 1

/turf/simulated/floor/land/can_engrave()
	return FALSE

/turf/simulated/floor/land/setup_local_ambient()
	set_ambient_light(COLOR_WHITE, 1)

/turf/simulated/floor/land/Destroy()
	. = ..()
	clear_ambient_light()
