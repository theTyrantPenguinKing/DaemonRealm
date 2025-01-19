extends CrouchFSM
class_name Crouched

func enter() -> void:
	animation_player.play("crouch", -1.0, actor.player_data.crouching_speed)

func exit() -> void:
	animation_player.play("crouch", -1.0, -actor.player_data.crouching_speed,\
			true)

func update() -> void:
	if Input.is_action_just_released("crouch"):
		SignalBus.player_crouch_state_changed.emit(self, "uncrouched")
