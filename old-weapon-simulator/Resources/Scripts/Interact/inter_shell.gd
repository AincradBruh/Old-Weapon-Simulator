extends StaticBody3D

var is_fix = true
var timer_node = null


func _ready() -> void:
	var timerr = get_tree().get_nodes_in_group("inter_timer")
	timer_node = timerr[0]
	timer_node.timeout.connect(_on_timer_timeout)


#  Взаимодействуем с батареями
func interact_to_e():
	if is_fix == false:
		timer_node.start()

#  Выполняем евент
func _on_timer_timeout():
	is_fix = true
	EventManager.shell_event()
