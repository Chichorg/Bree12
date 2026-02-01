/obj/structure/bed/despawn_bed
	var/time_till_despawn = 5 SECONDS
	var/time_entered = 0
	var/list/preserve_items = list()

/obj/structure/bed/despawn_bed/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/bed/despawn_bed/AttemptBuckle(mob/living/target, mob/living/user)
	if ((. = ..()))
		START_PROCESSING(SSobj, src)
		time_entered = world.time
		// to_chat(buckled_mob, SPAN_NOTICE("<b>If you ghost, log out or close your client now, your character will shortly be permanently removed from the round.</b>"))
	return

/obj/structure/bed/despawn_bed/Process()
	if (buckled_mob)
		if ((world.time - time_entered < time_till_despawn) && (buckled_mob.ckey))
			return
		despawn_mob()
	STOP_PROCESSING(SSobj, src)

/obj/structure/bed/despawn_bed/proc/despawn_mob()
	SHOULD_NOT_SLEEP(TRUE) // Sleeping causes the double-despawn bug

	if (QDELETED(buckled_mob))
		log_and_message_admins("A mob was deleted while on a despawn bed, or the despawn bed double-processed. This may cause errors!", null)
		return

	//Drop all items into the pod.
	for(var/obj/item/W in buckled_mob)
		buckled_mob.drop_from_inventory(W)
		W.forceMove(src)

		if(length(W.contents)) //Make sure we catch anything not handled by qdel() on the items.
			for(var/obj/item/O in W.contents)
				O.forceMove(src)

	//Delete all items not on the preservation list.
	var/list/items = src.contents.Copy()
	items -= buckled_mob

	for(var/obj/item/W in items)
		var/preserve = null

		for(var/T in preserve_items)
			if(istype(W,T))
				preserve = 1
				break

		if(!preserve)
			qdel(W)

	// //Update any existing objectives involving this mob.
	// for(var/datum/objective/O in all_objectives)
	// 	// We don't want revs to get objectives that aren't for heads of staff. Letting
	// 	// them win or lose based on cryo is silly so we remove the objective.
	// 	if(O.target == buckled_mob.mind)
	// 		if(O.owner && O.owner.current)
	// 			to_chat(O.owner.current, SPAN_WARNING("You get the feeling your target is no longer within your reach..."))
	// 		qdel(O)

	//Handle job slot/tater cleanup.
	if(buckled_mob.mind)
		if(buckled_mob.mind.assigned_job)
			buckled_mob.mind.assigned_job.clear_slot()

		if(LAZYLEN(buckled_mob.mind.objectives))
			buckled_mob.mind.objectives = null
			buckled_mob.mind.special_role = null

	var/mob/observer/ghost/ghost = buckled_mob.ghostize(0)
	if (ghost)
		ghost.timeofdeath = world.time
		announce_ghost_joinleave(ghost)

	// buckled_mob.ckey = null

	// Delete the mob.
	qdel(buckled_mob)
