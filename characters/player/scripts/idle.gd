extends MovementFSM
class_name Idle

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	var input_dir : Vector2 = Global.get_input_dir()
	
	if input_dir != Vector2.ZERO:
		SignalBus.player_movement_state_changed.emit(self, "walking")
		SignalBus.player_input_dir_changed.emit(input_dir,\
				actor.player_data.walking_speed)
	else:
		SignalBus.player_input_dir_changed.emit(input_dir, 0.0)
