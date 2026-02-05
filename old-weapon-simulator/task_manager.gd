extends Resource

var tasks = [
	{"task": "Задача 1", "description": "описание"},
	{"task": "Задача 2", "description": "описание"},
	{"task": "Задача 3", "description": "описание"},
	{"task": "Задача 4", "description": "описание"},
	{"task": "Задача 5", "description": "описание"}
]

var tasks_weight = [1, 1, 1, 1, 1]

func get_random_task() -> String:
	var random_index = randi() % tasks.size()
	return tasks[random_index]


func get_weight_random_task() -> String:
	var total_weight = 0
	for weight in tasks_weight:
		total_weight += weight
	
	var random_value = randi() % total_weight
	
	var current_weight = 0
	for task in range(tasks.size()):
		current_weight += tasks_weight[task]
		if random_value < current_weight:
			return tasks[task]
	
	return tasks[0]
	
