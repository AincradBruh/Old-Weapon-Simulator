extends Node3D

@export var player_shake = CharacterBody3D

var is_ready_shoot = false
var is_ready_azimuth = false
var is_ready_height = false
var is_ready_quest = false

var is_energy_activated = true
var is_driver_b_activated = true
var is_driver_s_activated = true

func _process(_delta: float) -> void:
	if (is_energy_activated and is_driver_b_activated and is_driver_s_activated) and (is_ready_shoot and is_ready_azimuth and is_ready_height and is_ready_quest):
		player_shake.shoot_shake_camera()
		is_ready_shoot = false
		is_ready_azimuth = false
		is_ready_height = false
		is_ready_quest = false
