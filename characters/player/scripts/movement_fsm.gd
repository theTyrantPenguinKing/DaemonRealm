extends Node
class_name MovementFSM

@export var initial_state : MovementFSM

@onready var actor : CharacterBody3D = self.owner

var current_state : MovementFSM = null
var states : Dictionary = {}
var mutex : Mutex = Mutex.new()
var key : String = ""

func _ready() -> void:
	SignalBus.player_movement_state_changed.connect(change_state)
	
	for child in self.get_children():
		states[child.name.to_lower()] = child
	
	if initial_state:
		current_state = initial_state
		key = current_state.name.to_lower()
		current_state.enter()

func _process(delta: float) -> void:
	if current_state:
		mutex.lock()
		current_state.update()
		mutex.unlock()

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	pass

func change_state(source_state : MovementFSM,\
		new_state_name : String) -> void:
	key = new_state_name.to_lower()
	
	# invalid source_state or key
	if not source_state or not key or key == "":
		return
	
	# source_state should be equal to current_state
	if source_state != current_state:
		return
	
	# the key should be in the dictionary
	if key not in states:
		return
	
	# change the current state
	mutex.lock()
	current_state.exit()
	current_state = states[key]
	current_state.enter()
	mutex.unlock()
