/mob/living/silicon/robot/Login()
	..()
	regenerate_icons()
	update_hud()

	show_laws(0)

	// BREE~SIERRA~SSINPUT~REMOVE
	// winset(src, null, "mainwindow.macro=borgmacro hotkey_toggle.is-checked=false input.focus=true input.background-color=#d3b5b5")
	// BREE~SIERRA~SSINPUT~REMOVEEND

	// Forces synths to select an icon relevant to their module
	if(!icon_selected)
		choose_icon(icon_selection_tries, module_sprites)

	if(hands)
		hands.icon_state = istype(module) ? lowertext(module.display_name) : "nomod"
