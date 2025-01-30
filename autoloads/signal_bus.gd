extends Node

# MAIN MENU SIGNALS
signal new_game_requested
signal load_game_requested(path : String)
signal save_game_requested(path : String)
signal settings_requested
signal quit_requested

# PLAYER SIGNALS
signal player_movement_state_changed(source_state : MovementFSM,\
		new_state_name : String)
signal player_jump_state_changed(source_state : JumpFSM,\
		new_state_name : String)
signal player_crouch_state_changed(source_state : CrouchFSM,\
		new_state_name : String)
signal player_input_dir_changed(input_dir : Vector2)

# DEBUG SIGNALS
signal debug_property_update_requested(prop_name : String, prop_info : String)
