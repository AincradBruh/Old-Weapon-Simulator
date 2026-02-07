extends Node

var tasks = [
	{"task": "Task 1", "description": "calibrate the artillery piece", "weight": 1},
	{"task": "Task 2", "description": "refuel the main engine", "weight": 3},  # В 3 раза чаще
	{"task": "Task 3", "description": "fix and calibrate the azimuth and altitude drivers", "weight": 1},
	{"task": "Task 4", "description": "fix the shell of an artillery piece", "weight": 5},  # В 5 раз чаще
	{"task": "Task 5", "description": "I did in my way", "weight": 1}
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
