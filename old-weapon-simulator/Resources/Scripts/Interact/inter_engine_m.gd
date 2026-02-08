extends StaticBody3D

@onready var gpu = $GPUParticles3D

var is_fix_m = true
var timer_node = null


func _ready() -> void:
	var timerr = get_tree().get_nodes_in_group("inter_timer")
	timer_node = timerr[0]
	timer_node.timeout.connect(_on_timer_timeout)


func _process(_delta: float) -> void:
	if is_fix_m == false:
		gpu.emitting = true


#  Взаимодействуем с батареями
func interact_to_e():
	if is_fix_m == false:
		timer_node.start()

#  Выполняем евент
func _on_timer_timeout():
	is_fix_m = true
	gpu.emitting = false
	EventManager.driver_event()
