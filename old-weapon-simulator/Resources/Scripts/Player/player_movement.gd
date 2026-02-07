extends CharacterBody3D

@onready var neck = $Neck
@onready var camera = $Neck/Camera3D
@onready var ray = $Neck/Camera3D/RayCast3D
@onready var flashlight = $Neck/Camera3D/Flashlight
@onready var audio_stream = $AudioStreamPlayer

@onready var flash_label = $CanvasLayer/UI/Others/FlashLabel
@onready var task_label = $CanvasLayer/UI/Tasks/Quests/TaskLabel
@onready var des_label = $CanvasLayer/UI/Tasks/Quests/DescriptionLabel
@onready var glodal_tasks_label = $CanvasLayer/UI/GlobalTasks/AllTasks

var speed = 4.0
var sprint = 7.0
var squat = 1.5
var jump_velocity = 4.5
var mouse_sensitivity = 0.0025
var flash_sfx = preload("res://Resources/Audio/SFX/Flashlight-Effect.wav")
var is_flash = false

# Сила тряски
var shake_strength: float = 0.02
# Длительность тряски в секундах
var shake_duration: float = 0.2

var original_scale = self.scale.y

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var current_task = TaskManager.get_random_task()
	var all_tasks = TaskManager.tasks
	task_label.text = current_task["task"]
	des_label.text = current_task["description"]
	glodal_tasks_label.text = str(all_tasks)

#  физика игрока
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	var input_dir := Input.get_vector("Action_A", "Action_D", "Action_W", "Action_S")
	var direction := (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if Input.is_action_pressed("Action_Shift"):
		if direction:
			velocity.x = direction.x * sprint
			velocity.z = direction.z * sprint
		else:
			velocity.x = move_toward(velocity.x, 0, sprint)
			velocity.z = move_toward(velocity.z, 0, sprint)
	
	elif Input.is_action_pressed("Action_Ctrl"):
		self.scale.y = 0.5
		if direction:
			velocity.x = direction.x * squat
			velocity.z = direction.z * squat
		else:
			velocity.x = move_toward(velocity.x, 0, squat)
			velocity.z = move_toward(velocity.z, 0, squat)
	
	else:
		self.scale.y = original_scale
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


#  вкл/выкл фонаря
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Action_F"):
		flashlight.visible = !flashlight.visible
		is_flash = !is_flash
		sound_stream(flash_sfx)
	
	if is_flash:
		flash_label.text = "Flashlight : on"
	else:
		flash_label.text = "Flashlight : off"

#  использование звуков
func sound_stream(sfx):
	audio_stream.stream = sfx
	audio_stream.play()

#  поворот экрана
func _input(event) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		neck.rotate_x(-event.relative.y * mouse_sensitivity)
		neck.rotation.x = clamp(neck.rotation.x, -PI / 2, PI / 2)
		rotate_y(-event.relative.x * mouse_sensitivity)


func shake_camera():
	var original_position = camera.position
	#var original_rotation = camera.rotation
	
	# Создаем Tween для плавной анимации
	var tween = create_tween()
	tween.set_parallel(true)  # Параллельные анимации
	
	# Быстрые случайные смещения
	for i in range(65):  # Количество "толчков"
		
		var target_offset = Vector3(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength * 0.5, shake_strength * 0.5)
		)
		
		# Очень короткая анимация для резкости
		tween.tween_property(camera, "position", camera.position + target_offset, 0.1).set_delay(i * 0.15)
		#tween.tween_property(camera, "rotation", camera.rotation + target_rotation, 0.1).set_delay(i * 0.15)
	
	# Возврат в исходное положение
	tween.chain().tween_property(camera, "position", original_position, 0.1).set_delay(0.2)
	#tween.chain().tween_property(camera, "rotation", original_rotation, 1).set_delay(0.2)


func shoot_shake_camera():
	var original_position = camera.position
	
	# Создаем Tween для плавной анимации
	var tween = create_tween()
	tween.set_parallel(true)  # Параллельные анимации
	
	# Быстрые случайные смещения
	for i in range(20):  # Количество "толчков"
		
		var target_offset = Vector3(
			randf_range(-shake_strength * 6, shake_strength * 6),
			randf_range(-shake_strength * 6, shake_strength * 6),
			randf_range(-shake_strength, shake_strength)
		)
		
		# Очень короткая анимация для резкости
		tween.tween_property(camera, "position", camera.position + target_offset, 0.1).set_delay(i * 0.15)
	
	# Возврат в исходное положение
	tween.chain().tween_property(camera, "position", original_position, 0.1).set_delay(0.2)
