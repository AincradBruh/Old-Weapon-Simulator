extends Node3D

@onready var fps_timer = $Timer

@onready var task_label = $SubViewport/CanvasLayer/TaskControl/Tasks/Quests/TaskLabel
@onready var des_label = $SubViewport/CanvasLayer/TaskControl/Tasks/Quests/DescriptionLabel
@onready var glodal_tasks_label = $SubViewport/CanvasLayer/TaskControl/GlobalTasks/AllTasks
@onready var coord_label = $SubViewport/CanvasLayer/TaskControl/Tasks/Quests/CoordLabel

var num = 0

var coord_x = range(0, 75, 5)
var coord_y = range(0, 360, 5)
var current_x = 0
var current_y = 0

var batteries = null
var batter_node = null
var shell = null
var shell_node = null
var drivers = null
var driver_m = null
var driver_s = null


func _ready() -> void:
	batteries = get_tree().get_nodes_in_group("batter")
	batter_node = batteries[0]
	shell = get_tree().get_nodes_in_group("shell")
	shell_node = shell[0]
	drivers = get_tree().get_nodes_in_group("drivers")
	driver_m = drivers[0]
	driver_s = drivers[1]
	new_task()


func new_task():
	var current_task = TaskManager.get_random_task()
	var all_tasks = TaskManager.tasks
	
	if current_task["task"] == "Fire Task":
		current_x = coord_x[randi() % coord_x.size()]
		current_y = coord_y[randi() % coord_y.size()]
		
		coord_label.text = "x: %s y: %s" % [current_x, current_y]
		coord_task()
	else:
		coord_label.text = ""
	
	if current_task["task"] == "Engine Task":
		batter_node.is_fuel = false
		batter_node.err_audio_on()
	
	if current_task["task"] == "Shell Task":
		shell_node.is_fix = false
	
	if current_task["task"] == "Drivers Task":
		driver_m.is_fix_m = false
		driver_s.is_fix_m = false
	
	task_label.text = current_task["task"]
	des_label.text = current_task["description"]
	glodal_tasks_label.text = str(all_tasks)


func coord_task() -> Array:
	var cur_x_to_y = [current_x, current_y]
	return cur_x_to_y
