extends Node3D

@export_range(1.0, 5.0, 0.1) var bob_frequency : float = 2.5
@export_range(0.01, 0.1, 0.01) var bob_amplitud : float = 0.05

@onready var actor : CharacterBody3D = self.owner

var bobbing_time : float

func _ready() -> void:
	bobbing_time = 0.0

func _physics_process(delta: float) -> void:
	bobbing_time += delta * actor.velocity.length() * \
			float(actor.is_on_floor())
	actor.camera.transform.origin = head_bobbing()

func head_bobbing() -> Vector3:
	var pos : Vector3 = Vector3.ZERO
	
	pos.y = sin(bobbing_time * bob_frequency) * bob_amplitud
	pos.x = cos(bobbing_time * bob_frequency) * bob_amplitud
	
	return pos
