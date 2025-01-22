extends JumpFSM
class_name JumpingAir

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	if actor.is_on_floor():
		SignalBus.player_jump_state_changed.emit(self, "notjumping")
