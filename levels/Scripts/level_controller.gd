extends Node
class_name Level

var level : Node3D

func _ready() -> void:
	pass

func load_level(path : String) -> bool:
	if level and not level.is_queued_for_deletion():
		level.queue_free()
	
	var success : bool = false
	
	if ResourceLoader.exists(path):
		level = ResourceLoader.load(path).instantiate()
		if level:
			add_child(level)
			success = true
			get_tree().paused = false
	
	return success
