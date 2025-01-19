extends MovementFSM
class_name Idle

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	actor.input_dir = Global.get_input_dir()
	
	if actor.input_dir != Vector2.ZERO:
		SignalBus.player_movement_state_changed.emit(self, "walking")
