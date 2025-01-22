extends MovementFSM
class_name Sprinting

func enter() -> void:
	actor.velocity.x = lerp(actor.velocity.x, actor.direction.x * \
			actor.player_data.sprinting_speed, actor.interpolation_amount)
	actor.velocity.z = lerp(actor.velocity.z, actor.direction.z * \
			actor.player_data.sprinting_speed, actor.interpolation_amount)

func exit() -> void:
	pass

func update() -> void:
	actor.input_dir = Global.get_input_dir()
	
	if actor.input_dir != Vector2.ZERO:
		actor.velocity.x = lerp(actor.velocity.x, actor.direction.x * \
				actor.player_data.sprinting_speed, actor.interpolation_amount)
		actor.velocity.z = lerp(actor.velocity.z, actor.direction.z * \
				actor.player_data.sprinting_speed, actor.interpolation_amount)
		
		if Input.is_action_just_released("sprint"):
			SignalBus.player_movement_state_changed.emit(self, "walking")
	else:
		SignalBus.player_movement_state_changed.emit(self, "idle")
