extends JumpFSM
class_name NotJumping

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	if actor.is_on_floor() and Input.is_action_pressed("jump"):
		SignalBus.player_jumped.emit(actor.player_data.jumping_speed)
		SignalBus.player_jump_state_changed.emit(self, "jumping")
