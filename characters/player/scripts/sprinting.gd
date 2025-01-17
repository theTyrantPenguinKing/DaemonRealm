extends MovementFSM
class_name Sprinting

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	var input_dir : Vector2 = Global.get_input_dir()
	
	if input_dir != Vector2.ZERO:
		if Input.is_action_just_released("sprint"):
			SignalBus.player_movement_state_changed.emit(self, "walking")
			SignalBus.player_input_dir_changed.emit(input_dir,\
					actor.player_data.walking_speed)
			return
		SignalBus.player_input_dir_changed.emit(input_dir,\
				actor.player_data.sprinting_speed)
	else:
		SignalBus.player_movement_state_changed.emit(self, "idle")
		SignalBus.player_input_dir_changed.emit(input_dir, 0.0)
