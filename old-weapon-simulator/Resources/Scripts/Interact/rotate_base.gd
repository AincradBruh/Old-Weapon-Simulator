extends Node3D

@onready var rotate_base = $"."
@onready var SFXdrivers = $"SFXdrivers"

@export var player_shake = CharacterBody3D
@export var angle_rotation = 5
@export var angle_duration = 10

var is_rotation: bool = false


func rotation_base(angle_deg):
	if is_rotation == true:
		return
	
	is_rotation = true
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	
	tween.tween_property(self, "rotation_degrees:y", angle_deg, angle_duration)
	
	player_shake.shake_camera()
	SFXdrivers.play()
	
	tween.finished.connect(_on_rotation_finished)


func _on_rotation_finished():
	is_rotation = false
	SFXdrivers.stop()


func _on_sf_xdrivers_finished() -> void:
	SFXdrivers.play()
