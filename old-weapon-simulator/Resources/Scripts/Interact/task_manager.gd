extends Node

var tasks = [
	{"task": "Fire Task", "description": "calibrate the artillery piece", "x": "cord_x", "y": "cord_y", "weight": 5},
	{"task": "Engine Task", "description": "refuel the main engine", "weight": 3},
	{"task": "Drivers Task", "description": "fix and calibrate the azimuth and altitude drivers", "weight": 1},
	{"task": "Shell Task", "description": "fix the shell of an artillery piece", "weight": 1},
]


func get_random_task() -> Dictionary:
	# Считаем общий вес
	var total_weight = 0
	for task in tasks:
		total_weight += task["weight"]
	
	# Выбираем случайное число
	var random_value = randi() % total_weight
	
	# Находим задачу по весу
	var current_weight = 0
	for task in tasks:
		current_weight += task["weight"]
		if random_value < current_weight:
			return task
	
	return tasks[0]  # fallback
