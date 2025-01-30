extends Control

@export var vbox : VBoxContainer

func _ready() -> void:
	SignalBus.debug_property_update_requested.connect(update_property)
	add_property("MovementFSM")
	add_property("JumpFSM")
	add_property("CrouchFSM")

func add_property(property_name : String) -> void:
	var found : bool = false
	
	for child in vbox.get_children():
		if child is Label and child.name == property_name:
			found = true
			break
	
	if not found:
		var label = Label.new()
		label.name = property_name
		vbox.add_child(label)

func update_property(property_name : String, property_info : String) -> void:
	var label : Label
	
	for child in vbox.get_children():
		if child is Label and child.name == property_name:
			label = child
			break
	
	if label:
		label.text = label.name + ": " + property_info
