extends CharacterBody3D

@export_group("Player Nodes")
@export var head : Node3D

@export_group("Camera Properties")
@export_range(0.1, 1.0, 0.1) var mouse_sensitivity : float = 0.4
@export_range(-90.0, -45.0, 0.1, "radians_as_degrees") var lower_tilt_angle \
: float = deg_to_rad(-75)
@export_range(45.0, 90.0, 0.1, "radians_as_degrees") var upper_tilt_angle \
: float = deg_to_rad(75)

const MAX_SPEED : float = 4.0
var speed : float
const SPEED_VARIATION : float = 1 / 8.0

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, lower_tilt_angle,\
		upper_tilt_angle)
	

func _process(delta: float) -> void:
	SignalBus.update_debug_label.emit("fps", str(1.0 / delta))

func _physics_process(delta: float) -> void:
	if position.y < -1.0:
		position = Vector3.ZERO
	
	var direction : Vector3 = get_direction()
	
	horizontal_motion(direction)
	
	# applies gravity
	velocity += get_gravity() * delta
	
	# commits the movement
	move_and_slide()

func get_direction() -> Vector3:
	var input_dir : Vector2 = Input.get_vector("strafe_left", "strafe_right",\
	"move_forward", "move_backward").normalized()
	
	return global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)

func horizontal_motion(vec : Vector3) -> void:
	if vec:
		speed = lerp(speed, MAX_SPEED, SPEED_VARIATION)
		velocity.x = vec.x * speed
		velocity.z = vec.z * speed
	else:
		speed = lerp(speed, 0.0, SPEED_VARIATION)
		velocity.x = speed
		velocity.z = speed
