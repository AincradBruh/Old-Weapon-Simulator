extends MeshInstance3D

@onready var rotate_can = $"."

@export var angle_rotation = 0.1
@export var max_rotate = 90
@export var min_rotate = 15
@export var rotate_speed = 5

var current_rotation_x = rotation.x


func _process(_delta: float) -> void:
	if Input.is_action_pressed("Action_W"):
		if rad_to_deg(current_rotation_x) > min_rotate:
			rotate_can.rotation.x = rotation.x - deg_to_rad(angle_rotation)
			current_rotation_x = rotation.x
		
	if Input.is_action_pressed("Action_S"):
		if rad_to_deg(current_rotation_x) < max_rotate:
			rotate_can.rotation.x = rotation.x + deg_to_rad(angle_rotation)
			current_rotation_x = rotation.x
