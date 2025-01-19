extends MovementFSM
class_name Sprinting

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	actor.input_dir = Global.get_input_dir()
	
	if actor.input_dir != Vector2.ZERO:
		if Input.is_action_just_released("sprint"):
			SignalBus.player_movement_state_changed.emit(self, "walking")
	else:
		SignalBus.player_movement_state_changed.emit(self, "idle")
