extends Node3D

@onready var rotate_base = $"."
@onready var SFXdrivers = $"SFXdrivers"

@export var angle_rotation = 5
@export var angle_duration = 3
@export var rotate_speed = 5

var is_rotation: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left") and not is_rotation:
		rotation_base(angle_rotation)
		
	elif Input.is_action_just_pressed("ui_right") and not is_rotation:
		rotation_base(-angle_rotation)


func rotation_base(angle_deg):
	if is_rotation == true:
		return
	
	is_rotation = true
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "rotation_degrees:y", rotation_degrees.y + angle_deg, angle_duration)
	
	tween.finished.connect(_on_rotation_finished)


func _on_rotation_finished():
	is_rotation = false


func _on_sf_xdrivers_finished() -> void:
	SFXdrivers.play()
