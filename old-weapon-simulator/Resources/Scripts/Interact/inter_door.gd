extends StaticBody3D

@export var angle_rotation = 120
@export var angle_duration = 5
@onready var door = $"../../.."

var is_open = false
var target_rotation = Vector3.ZERO

func _ready() -> void:
	target_rotation = door.rotation_degrees

func opening_door():
	if is_open:
		# Закрываем дверь - возвращаем в начальное положение
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_EXPO)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(door, "rotation_degrees", target_rotation, angle_duration)
	else:
		# Открываем дверь - поворачиваем на угол
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_EXPO)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(door, "rotation_degrees", target_rotation + Vector3(angle_rotation, 0, 0), angle_duration)
	
	is_open = !is_open
