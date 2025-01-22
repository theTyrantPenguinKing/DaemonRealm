extends JumpFSM
class_name Jumping

func enter() -> void:
	pass

func exit():
	pass

func update() -> void:
	if not actor.is_on_floor() and Input.is_action_just_pressed("jump"):
		SignalBus.player_jump_state_changed.emit(self, "jumpingair")
		actor.velocity.y = actor.player_data.jumping_speed
	
	if actor.is_on_floor():
		SignalBus.player_jump_state_changed.emit(self, "notjumping")
