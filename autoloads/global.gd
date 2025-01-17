extends Node

func get_input_dir() -> Vector2:
	return Input.get_vector("strafe_left", "strafe_right",\
			"move_forward", "move_backward").normalized()
