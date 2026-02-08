extends StaticBody3D

@onready var label_x = $Label_x
@onready var cannon = $"../../../../rotateCannon/Cannon"

@export var max_rotate = 90
@export var min_rotate = 15

var rotate_angle = 0
var rotate_angle_wheel = 90


func slide():
	if Input.is_action_just_pressed("Mouse_Wheel_Up"):
		if rotate_angle_wheel > min_rotate:
			rotate_angle_wheel -= 5
			rotate_angle += 5
		
	elif Input.is_action_just_pressed("Mouse_Wheel_Down"):
		if rotate_angle_wheel < max_rotate:
			rotate_angle_wheel += 5
			rotate_angle -= 5
		
	label_x.text = "x: " + str(rotate_angle) + " deg."


func interact_to_e():
	cannon.rotation_base(rotate_angle_wheel)
	EventManager.event_x = rotate_angle
