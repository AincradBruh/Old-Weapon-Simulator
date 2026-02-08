extends StaticBody3D

@onready var err_audio = $ErrBatteriesAudio

var is_fuel = true
var timer_node = null


func _ready() -> void:
	var timer = get_tree().get_nodes_in_group("inter_timer")
	timer_node = timer[0]
	timer_node.timeout.connect(_on_timer_timeout)

#  включаем аудио
func err_audio_on():
	err_audio.play()

#  Взаимодействуем с батареями
func interact_to_e():
	if is_fuel == false:
		timer_node.start()

#  Выполняем евент
func _on_timer_timeout():
	is_fuel = true
	err_audio.stop()
	EventManager.engine_event()
