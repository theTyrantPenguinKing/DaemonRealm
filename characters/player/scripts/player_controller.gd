extends CharacterBody3D
class_name PlayerController

@export_group("Player Nodes")
@export var camera_controller : Node3D
@export var player_data : Resource

@export_group("Mouse Properties")
@export_range(0.10, 1.00, 0.01) var horizontal_sensitivity : float = 0.45
@export_range(0.10, 1.00, 0.01) var vertical_sensitivity : float = 0.45

@export_group("Camera Properties")
@export_range(-90.0, -45.0, 0.1, "radians_as_degrees") \
		var lower_vertical_angle : float = deg_to_rad(-75.0)
@export_range(45.0, 90.0, 0.1, "radians_as_degrees") \
		var upper_vertical_angle : float = deg_to_rad(75.0)

var direction : Vector3
var speed : float
var interpolation_amount : float = 1 / 8.0

func _ready() -> void:
	SignalBus.player_input_dir_changed.connect(update_direction)
	SignalBus.player_jumped.connect(jump_update)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var rot_hor : float = deg_to_rad(-event.relative.x) * \
				horizontal_sensitivity
		var rot_ver : float = deg_to_rad(-event.relative.y) * \
				vertical_sensitivity
		
		rotate_y(rot_hor)
		camera_controller.rotate_x(rot_ver)
		camera_controller.rotation.x = clamp(camera_controller.rotation.x,\
				lower_vertical_angle, upper_vertical_angle)

func _physics_process(delta: float) -> void:
	# apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	update_velocity()
	move_and_slide()

func update_direction(input_dir : Vector2, new_speed : float) -> void:
	direction = global_transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)
	speed = new_speed

func jump_update(jump_speed : float) -> void:
	velocity.y = jump_speed

func update_velocity() -> void:
	velocity.x = lerp(velocity.x, direction.x * speed,\
			interpolation_amount)
	velocity.z = lerp(velocity.z, direction.z * speed,\
			interpolation_amount)
