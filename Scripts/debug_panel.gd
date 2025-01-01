extends Control

@export var panel_container : PanelContainer

func _ready() -> void:
	hide()
	
	add_label("fps")
	
	SignalBus.debug_panel_requested.connect(display_debug_panel)
	SignalBus.update_debug_label.connect(update_label)

func add_label(label_name : String, label_text : String = "") -> void:
	var found : bool = false
	for child in panel_container.get_children():
		if child.name == label_name:
			found = true
			break
	
	if not found:
		var label : Label = Label.new()
		
		label.name = label_name.to_lower()
		label.text = label_name + ": " + label_text
		
		panel_container.add_child(label)
	

func update_label(label_name : String, label_text : String) -> void:
	var label : Label = null
	
	for child in panel_container.get_children():
		if child.name == label_name:
			label = child
			break
	
	if label:
		label.text = label_name + ": " + label_text

func display_debug_panel() -> void:
	if panel_container.get_child_count() > 0:
		visible = not visible
