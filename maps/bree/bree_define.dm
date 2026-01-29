/datum/map/bree
	name = "\improper Bree"
	full_name = "\improper Hamlet of Bree"
	path = "bree"

	station_levels = list(1, 2, 3)
	// admin_levels = list()
	contact_levels = list(1, 2, 3)
	player_levels = list(1, 2, 3)
	// sealed_levels = list()
	// empty_levels = null
	// escape_levels = list()

	// base_turf_by_z = list()
	// usable_email_tlds = list("freemail.net")
	// base_floor_type
	// base_floor_area

	// accessible_z_levels = list()

	allowed_jobs = list(
		/datum/job/bree/innkeeper,
		/datum/job/bree/adventurer
	)

	station_name  = "\improper Hamlet of Bree"
	station_short = "\improper Bree"
	dock_name     = "THE PirateBay"
	boss_name     = "Captain Roger"
	boss_short    = "Cap'"
	company_name  = "BadMan"
	company_short = "BM"
	system_name   = "Uncharted System"

	// map_admin_faxes = list()

	shuttle_docked_message = "The shuttle has docked."
	shuttle_leaving_dock = "The shuttle has departed from home dock."
	shuttle_called_message = "A scheduled transfer shuttle has been sent."
	shuttle_recall_message = "The shuttle has been recalled"
	emergency_shuttle_docked_message = "The emergency escape shuttle has docked."
	emergency_shuttle_leaving_dock = "The emergency escape shuttle has departed from %dock_name%."
	// emergency_shuttle_called_message = "An emergency escape shuttle has been sent."
	emergency_shuttle_recall_message = "The emergency shuttle has been recalled"

	allowed_spawns = list("Arrivals Shuttle","Gateway", "Cryogenic Storage", "Cyborg Storage")
	default_spawn = "Arrivals Shuttle"
	// flags = 0
	// evac_controller_type = /datum/evacuation_controller
	use_overmap = 0
	using_sun = FALSE
	overmap_size = 2
	overmap_z = 0
	overmap_event_areas = 0

	lobby_screens = list('maps/bree/lobby.png')
	lobby_tracks = list()

	welcome_sound = null

	// default_law_type = /datum/ai_laws/nanotrasen
	// security_state = /singleton/security_state/default

	id_hud_icons = 'icons/mob/hud.dmi'

	// num_exoplanets = 0
	// planet_size
	// away_site_budget = -1
	// min_offmap_players = 0

	// starting_money = 75000
	// department_money = 5000
	// salary_modifier	= 1
	// station_departments = list()

	// local_currency_name = "thalers"
	// local_currency_name_singular = "thaler"
	// local_currency_name_short = "T"

	available_cultural_info = list(
		TAG_HOMEWORLD = list(
			HOME_SYSTEM_MARS
		),
		TAG_FACTION = list(
			FACTION_SOL_CENTRAL
		),
		TAG_CULTURE = list(
			CULTURE_HUMAN_MARTIAN
		),
		TAG_RELIGION = list(
			RELIGION_UNSTATED
		)
	)

	default_cultural_info = list(
		TAG_HOMEWORLD = HOME_SYSTEM_MARS,
		TAG_FACTION =   FACTION_SOL_CENTRAL,
		TAG_CULTURE =   CULTURE_HUMAN_MARTIAN,
		TAG_RELIGION =  RELIGION_AGNOSTICISM
	)

	map_event_container = list()

/datum/map/bree/build_away_sites()
	SSticker.start_ASAP = TRUE
	return
