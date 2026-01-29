extends CharacterBody3D

@onready var neck = $Neck
@onready var camera = $Neck/Camera3D
@onready var ray = $Neck/Camera3D/RayCast3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouse_sensitivity = 0.0025


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		neck.rotate_x(-event.relative.y * mouse_sensitivity)
		neck.rotation.x = clamp(neck.rotation.x, -PI / 2, PI / 2)
		rotate_y(-event.relative.x * mouse_sensitivity)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("Action_A", "Action_D", "Action_W", "Action_S")
	var direction := (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
