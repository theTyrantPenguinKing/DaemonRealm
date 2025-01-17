extends Control
class_name Menu

@export_group("Buttons")
@export var new_game_button : Button
@export var load_button : Button
@export var save_button : Button
@export var settings_button : Button
@export var quit_button : Button

var submenu : Menu

func _ready() -> void:
	pass

func _on_visibility_changed() -> void:
	new_game_button.call_deferred("grab_focus")
	

func _on_new_game_button_pressed() -> void:
	SignalBus.new_game_requested.emit()

func _on_load_button_pressed() -> void:
	pass # Replace with function body.


func _on_save_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	var conf : ConfirmationDialog = ConfirmationDialog.new()
	add_child(conf)
	
	conf.position = (get_window().size - conf.size) / 2
	conf.visible = true
	
	conf.dialog_text = "Do you want to quit?"
	
	conf.get_ok_button().text = "Yes"
	conf.get_ok_button().pressed.connect(quitting)
	
	conf.get_cancel_button().text = "No"
	conf.get_cancel_button().grab_focus()
	conf.get_cancel_button().pressed.connect(destroy_quit_confirmation.bind(conf))
	
	conf.canceled.connect(destroy_quit_confirmation.bind(conf))

func quitting() -> void:
	SignalBus.quit_requested.emit()

func destroy_quit_confirmation(conf : ConfirmationDialog) -> void:
	if not conf.is_queued_for_deletion():
		conf.queue_free()
