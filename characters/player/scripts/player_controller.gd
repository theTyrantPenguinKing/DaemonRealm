extends CharacterBody3D
class_name PlayerController

@export_group("Player Nodes")
@export var camera_controller : Node3D
@export var camera : Camera3D
@export var player_data : Resource

@export_group("Mouse Properties")
@export_range(0.10, 1.00, 0.01) var horizontal_sensitivity : float = 0.45
@export_range(0.10, 1.00, 0.01) var vertical_sensitivity : float = 0.45

@export_group("Camera Properties")
@export_range(-90.0, -45.0, 0.1, "radians_as_degrees") \
		var lower_vertical_angle : float = deg_to_rad(-75.0)
@export_range(45.0, 90.0, 0.1, "radians_as_degrees") \
		var upper_vertical_angle : float = deg_to_rad(75.0)

@export_group("Head Bobbing Parameters")
@export_range(1.0, 4.0, 0.1) var bob_frequency : float = 2.0
@export_range(0.01, 0.1, 0.01) var bob_amplitude : float = 0.05

var input_dir : Vector2
var direction : Vector3
var speed : float
var interpolation_amount = 0.15
var bob_time : float = 0.0

func _ready() -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var rot_hor : float = deg_to_rad(-event.relative.x) * \
				horizontal_sensitivity
		var rot_ver : float = deg_to_rad(-event.relative.y) * \
				vertical_sensitivity
		
		camera_controller.rotate_y(rot_hor)
		camera.rotate_x(rot_ver)
		camera.rotation.x = clamp(camera.rotation.x,\
				lower_vertical_angle, upper_vertical_angle)

func _physics_process(delta: float) -> void:
	# apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	update_direction()
	
	bob_time += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = head_bob(bob_time)
	
	move_and_slide()

func update_direction() -> void:
	direction = camera_controller.transform.basis * \
			Vector3(input_dir.x, 0.0, input_dir.y)

func head_bob(time : float) -> Vector3:
	var pos : Vector3 = Vector3.ZERO
	
	pos.y = sin(time * bob_frequency) * bob_amplitude
	pos.x = cos(time * bob_frequency) * bob_amplitude
	
	return pos
