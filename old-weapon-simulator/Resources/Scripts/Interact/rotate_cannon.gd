extends MeshInstance3D

@onready var rotate_can = $".."
@onready var SFXcannon = $"../../../SFXcannon"


@export var player_shake = CharacterBody3D
@export var angle_rotation = 5
@export var angle_duration = 10

var current_rotation_x = rad_to_deg(rotation.x)
var is_rotation: bool = false


func rotation_base(angle_deg):
	if is_rotation == true:
		return
	
	is_rotation = true
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	
	tween.tween_property(self, "rotation_degrees:x", angle_deg, angle_duration) #  (n < 90) / 5 = x
	
	player_shake.shake_camera()
	SFXcannon.play()
	
	tween.finished.connect(_on_rotation_finished)


func _on_rotation_finished():
	is_rotation = false
	SFXcannon.stop()
	


func _on_sf_xcannon_finished() -> void:
	SFXcannon.play()
