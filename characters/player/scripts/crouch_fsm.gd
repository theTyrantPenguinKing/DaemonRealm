extends Node
class_name CrouchFSM

@export var initial_state : CrouchFSM
@onready var actor : CharacterBody3D = self.owner

var current_state : CrouchFSM
var states : Dictionary = {}
var mutex : Mutex = Mutex.new()
@onready var animation_player = %AnimationPlayer

func _ready() -> void:
	SignalBus.player_crouch_state_changed.connect(change_state)
	
	for child in self.get_children():
		if child is CrouchFSM:
			states[child.name.to_lower()] = child
	
	if initial_state:
		current_state = initial_state
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

func change_state(source_state : CrouchFSM, new_state_name : String) -> void:
	var key : String = new_state_name.to_lower()
	
	if not source_state or not key or key == "":
		return
	
	if source_state != current_state:
		return
	
	if key not in states:
		return
	
	mutex.lock()
	current_state.exit()
	current_state = states[key]
	current_state.enter()
	mutex.unlock()
