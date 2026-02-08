extends StaticBody3D

@onready var fire_timer = $FireTimer
@onready var cannon = $"../../../../rotateCannon/Cannon"
@onready var label_timer = $TimerLabel

var ready_fire = true


func _process(_delta: float) -> void:
	label_timer.text = str(int(fire_timer.time_left))


func interact_to_e():
	if ready_fire == true:
		cannon.fire_cannon()
		EventManager.fire_event()
		ready_fire = false
		fire_timer.start()
		label_timer.visible = true


func _on_fire_timer_timeout() -> void:
	ready_fire = true
	label_timer.visible = false
