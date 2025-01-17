extends CrouchFSM
class_name Uncrouched

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	if Input.is_action_pressed("crouch"):
		SignalBus.player_crouch_state_changed.emit(self, "crouched")
