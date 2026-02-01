/obj/structure/reagent_dispensers/barrel
	name = "barrel"
	icon = 'bree/icons/obj/structure/barrel.dmi'
	icon_state = "base"
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_CAN_TABLE

/obj/structure/reagent_dispensers/barrel/beer
	desc = "A barrel of beer."
	initial_reagent_types = list(/datum/reagent/ethanol/beer = 1)

/obj/structure/reagent_dispensers/barrel/ale
	desc = "A barrel of ale."
	initial_reagent_types = list(/datum/reagent/ethanol/ale = 1)

/obj/structure/reagent_dispensers/barrel/mead
	desc = "A barrel of mead."
	initial_reagent_types = list(/datum/reagent/ethanol/mead = 1)

/obj/structure/reagent_dispensers/barrel/wine
	desc = "A barrel of wine."
	initial_reagent_types = list(/datum/reagent/ethanol/wine = 1)
