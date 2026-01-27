extends Node3D

@onready var rotate_base = $"."

@export var angle_rotation = 0.1
@export var max_rotate = 90
@export var min_rotate = 15
@export var rotate_speed = 5


func _process(_delta: float) -> void:
	if Input.is_action_pressed("Action_A"):
		rotate_base.rotation.y = rotation.y + deg_to_rad(angle_rotation)
		
	if Input.is_action_pressed("Action_D"):
		rotate_base.rotation.y = rotation.y - deg_to_rad(angle_rotation)
