extends Node

var level : Node3D = null
var main_menu : Control = null
var debug_panel : Control = null

func _ready() -> void:
	get_tree().paused = true
	load_main_menu()
	
	debug_panel = load("res://UI/debug_panel.tscn").instantiate()
	add_child(debug_panel)
	
	main_menu_signals()
	debug_panel_signals()

func _process(delta: float) -> void:
	if get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("open_menu"):
		if not main_menu:
			load_main_menu()
			get_tree().paused = true
		else:
			if level:
				delete_main_menu()
				level.show()
				get_tree().paused = false
	
	if Input.is_action_just_pressed("debug_panel"):
		SignalBus.debug_panel_requested.emit()

func create_new_game():
	if load_level("res://Levels/map_1.tscn"):
		delete_main_menu()
		get_tree().paused = false

func exit_game() -> void:
	get_tree().quit()

func main_menu_signals() -> void:
	SignalBus.new_game_selected.connect(create_new_game)
	SignalBus.exit_request_confirmed.connect(exit_game)

func debug_panel_signals() -> void:
	pass

func load_main_menu() -> void:
	if not main_menu:
		main_menu = load("res://UI/main_menu.tscn").instantiate()
		add_child(main_menu)

func delete_main_menu() -> void:
	main_menu.queue_free()
	main_menu = null

func load_level(path : String) -> bool:
	var level_resource : Resource = ResourceLoader.load(path)
	
	if level_resource:
		level = level_resource.instantiate()
		add_child(level)
		return true
	else:
		return false

func delete_level() -> void:
	level.queue_free()
	level = null

func delete_accept_dialog(accpt : AcceptDialog) -> AcceptDialog:
	if not accpt.is_queued_for_deletion():
		accpt.queue_free()
	return null
