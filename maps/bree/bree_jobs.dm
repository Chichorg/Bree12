/datum/job/bree
	department_flag = BRE
	req_admin_notify = 1
	create_record = 0
	account_allowed = 0
	loadout_allowed = TRUE
	announced = FALSE
	latejoin_at_spawnpoints

/datum/job/bree/innkeeper
	title = "Innkeeper"
	total_positions = 1
	spawn_positions = 1

	supervisors = ""
	selection_color = COLOR_WARM_YELLOW

	outfit_type = /singleton/hierarchy/outfit/job/captain

/datum/job/bree/adventurer
	title = "Adventurer"
	total_positions = -1
	spawn_positions = -1

	supervisors = ""
	selection_color = COLOR_BOTTLE_GREEN

	outfit_type = /singleton/hierarchy/outfit/job/captain

	is_semi_antagonist = TRUE
