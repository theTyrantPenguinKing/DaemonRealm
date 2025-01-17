extends Node

var main_menu : Menu
var level_controller : Level

func _ready() -> void:
	get_tree().paused = true
	
	main_menu = load("res://ui/main_menu.tscn").instantiate()
	add_child(main_menu)
	
	level_controller = load("res://levels/level_controller.tscn").instantiate()
	add_child(level_controller)
	
	main_menu_signals()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_menu"):
		if main_menu.submenu:
			main_menu.submenu.queue_free()
			main_menu.show()
		else:
			if level_controller.level:
				get_tree().paused = not get_tree().paused
	
	if get_tree().paused:
		main_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		main_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func main_menu_signals() -> void:
	SignalBus.new_game_requested.connect(create_new_game)
	SignalBus.quit_requested.connect(quit_game)

func create_new_game() -> void:
	if level_controller.load_level("res://levels/map_1.tscn"):
		main_menu.hide()

func quit_game() -> void:
	get_tree().quit()
