extends MovementFSM
class_name Idle

func enter() -> void:
	actor.velocity.x = lerp(actor.velocity.x, 0.0, actor.interpolation_amount)
	actor.velocity.z = lerp(actor.velocity.z, 0.0, actor.interpolation_amount)

func exit() -> void:
	pass

func update() -> void:
	actor.input_dir = Global.get_input_dir()
	
	if actor.input_dir != Vector2.ZERO:
		SignalBus.player_movement_state_changed.emit(self, "walking")
	else:
		actor.velocity.x = lerp(actor.velocity.x, 0.0,\
				actor.interpolation_amount)
		actor.velocity.z = lerp(actor.velocity.z, 0.0,\
				actor.interpolation_amount)
