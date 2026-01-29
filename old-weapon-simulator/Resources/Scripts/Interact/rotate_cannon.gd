extends MeshInstance3D

@onready var rotate_can = $"."
@onready var SFXcannon = $"../../../SFXcannon"

@export var angle_rotation = 5
@export var angle_duration = 3
@export var max_rotate = 90
@export var min_rotate = 20

var current_rotation_x = rad_to_deg(rotation.x)
var is_rotation: bool = false


func _process(_delta: float) -> void:
	print(current_rotation_x)
	if Input.is_action_just_pressed("ui_up") and not is_rotation:
		if current_rotation_x > min_rotate:
			print(current_rotation_x)
			rotation_base(-angle_rotation)
			current_rotation_x -= 5
		
	elif Input.is_action_just_pressed("ui_down") and not is_rotation:
		if current_rotation_x < max_rotate:
			print(current_rotation_x)
			rotation_base(angle_rotation)
			current_rotation_x += 5


func rotation_base(angle_deg):
	if is_rotation == true:
		return
	
	is_rotation = true
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "rotation_degrees:x", rotation_degrees.x + angle_deg, angle_duration)
	
	tween.finished.connect(_on_rotation_finished)


func _on_rotation_finished():
	is_rotation = false
