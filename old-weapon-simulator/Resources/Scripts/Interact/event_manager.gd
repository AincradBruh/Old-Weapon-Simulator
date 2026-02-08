extends Node

var monitor_events = null
var congrats_label = null
var timer_event = null
var batteries = null

var event_x = 0
var event_y = 0

var monitor_node = null
var congrats_node = null
var timer_node = null
var batter_node = null
var drivers = null
var driver_m = null
var driver_s = null


func initialized_nodes():
	monitor_events = get_tree().get_nodes_in_group("monitor")
	congrats_label = get_tree().get_nodes_in_group("label")
	timer_event = get_tree().get_nodes_in_group("timer")
	batteries = get_tree().get_nodes_in_group("batter")
	drivers = get_tree().get_nodes_in_group("drivers")
	driver_m = drivers[0]
	driver_s = drivers[1]
	
	monitor_node = monitor_events[0]
	congrats_node = congrats_label[0]
	timer_node = timer_event[0]
	timer_node.timeout.connect(_on_timer_timeout)
	batter_node = batteries[0]


func fire_event():
	var coords = monitor_node.coord_task()
	var task_x = coords[0]
	var task_y = coords[1]
	if event_x == task_x and event_y == task_y:
		congrats_event()


func engine_event():
	congrats_event()


func driver_event():
	if driver_m.is_fix_m == true and driver_s.is_fix_m == true:
		congrats_event()


func shell_event():
	congrats_event()


func congrats_event():
	congrats_node.visible = true
	timer_node.start()


func _on_timer_timeout():
	congrats_node.visible = false
	monitor_node.new_task()
