extends Node3D

@export var day_duration: float = 900.0 #  15 реальных минут
@export var night_duration: float = 300.0 #  5 реальных минут

@onready var sun: DirectionalLight3D = $DirectionalLight3D
@onready var environment: WorldEnvironment = $WorldEnvironment

@onready var alarm_audio = $AlarmAudio
@onready var alarm_light = $Weapon/WeaponFixed/RotateBase/Lights/AlarmLight
@onready var main_light = $Weapon/WeaponFixed/RotateBase/Lights/MainLight

var is_play = false
var time_of_day: float = 0.0
var is_day: bool = true
var cycle_progress: float = 0.0
var sun_rotation
var sun_intensity
var rotation_day_night = 0.0
var game_time: float = 0.0  # В часах
var real_time_elapsed: float = 0.0
var game_hours_per_real_second: float = 1.2 / 60.0  # 2 часа/60 секунд
var days_count = 0


func _ready() -> void:
	#get_tree().create_timer(1).timeout.connect(AlarmSiren)
	# Начальные настройки
	sun.light_energy = 1.0
	environment.environment.ambient_light_energy = 0.2


func alarm_siren():
	if is_play == false:
		main_light.visible = !main_light.visible
		await get_tree().create_timer(3).timeout
		alarm_light.visible = !alarm_light.visible
		alarm_audio.play()
		is_play = true
	else:
		main_light.visible = !main_light.visible
		alarm_light.visible = !alarm_light.visible
		alarm_audio.stop()
		is_play = false


func _on_alarm_audio_finished() -> void:
	alarm_siren()


func _process(delta):
	update_day_night_cycle(delta)
	real_time_elapsed += delta
	
	# Обновляем игровое время
	game_time += delta * game_hours_per_real_second
	
	# Проверяем переход через полночь
	if game_time >= 24.0:
		game_time = fmod(game_time, 24.0)
		days_count += 1
	
	# Получаем часы и минуты
	var hour = int(game_time)
	var minute = int((game_time - hour) * 60)
	
	
	# Обновляем каждую секунду игрового времени
	# или используем дельту для плавного обновления
	update_time_display(hour, minute, days_count)

func update_day_night_cycle(delta):
	var cycle_duration = day_duration if is_day else night_duration
	
	# Обновляем прогресс цикла
	cycle_progress += delta / cycle_duration
	rotation_day_night += delta / cycle_duration
	
	if cycle_progress >= 1.0:
		cycle_progress = 0.0
		is_day = !is_day
	
	update_lighting()
	

func update_lighting():
	# Дневное освещение
	sun_intensity = smoothstep(0, 0.5, 1) * 2.0
	sun_intensity = clamp(sun_intensity, 0.1, 1.0)
	sun.light_energy = sun_intensity
	
	# Вращение солнца
	sun_rotation = rotation_day_night * -180  # 180 градусов за день
	sun.rotation_degrees.x = sun_rotation
	
	if sun.rotation_degrees.x >= 360:
		sun.rotation_degrees.x = 0

@onready var time_label = $CanvasLayer/MainUI/VBoxContainer/TimeLabel
@onready var day_night_label = $CanvasLayer/MainUI/VBoxContainer/DayNightLabel
@onready var day_count_label = $CanvasLayer/MainUI/VBoxContainer/DayCountLabel

func update_time_display(hour, minute, days):
	var minutes = int(hour)# / 60
	var seconds = int(minute)# % 60
	
	time_label.text = "Time: %02d:%02d" % [minutes, seconds]
	day_night_label.text = "Now: %s" % ("Daytime" if is_day else "Night")
	day_count_label.text = "Been days: " + str(days)
	
