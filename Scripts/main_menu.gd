extends Control

@export_group("Buttons")
@export var new_game_button : Button
@export var load_button : Button
@export var save_button : Button
@export var settings_button : Button
@export var exit_button : Button

func _ready() -> void:
	new_game_button.call_deferred("grab_focus")


func _on_new_game_button_pressed() -> void:
	SignalBus.new_game_selected.emit()


func _on_load_button_pressed() -> void:
	pass # Replace with function body.


func _on_save_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	var _conf : ConfirmationDialog = create_exit_confirmation()

func create_exit_confirmation() -> ConfirmationDialog:
	var conf : ConfirmationDialog = ConfirmationDialog.new()
	add_child(conf)
	
	conf.position = (get_window().size - conf.size) / 2
	conf.visible = true
	
	conf.dialog_text = "Do you want to quit?"
	
	conf.get_ok_button().text = "Yes"
	conf.get_ok_button().pressed.connect(exit_confirmed.bind(conf))
	
	conf.get_cancel_button().text = "No"
	conf.get_cancel_button().grab_focus()
	conf.get_cancel_button().pressed.connect(delete_exit_confirmation.bind(conf))
	
	conf.canceled.connect(delete_exit_confirmation.bind(conf))
	
	return conf

func delete_exit_confirmation(conf : ConfirmationDialog) -> ConfirmationDialog:
	conf.queue_free()
	conf = null
	return conf

func exit_confirmed(conf : ConfirmationDialog) -> void:
	SignalBus.exit_request_confirmed.emit()
	delete_exit_confirmation(conf)
