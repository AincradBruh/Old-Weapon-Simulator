extends StaticBody3D

@onready var label_x = $Label_y
@onready var cannon = $"../../../../.."

var rotate_angle = 0
var rotate_angle_wheel = 0


func slide():
	if Input.is_action_just_pressed("Mouse_Wheel_Up"):
		rotate_angle_wheel -= 5
		rotate_angle += 5
		
	elif Input.is_action_just_pressed("Mouse_Wheel_Down"):
		rotate_angle_wheel += 5
		rotate_angle -= 5
	
	label_x.text = "y: " + str(rotate_angle) + " deg."


func interact_to_e():
	cannon.rotation_base(rotate_angle_wheel)
	EventManager.event_y = rotate_angle
