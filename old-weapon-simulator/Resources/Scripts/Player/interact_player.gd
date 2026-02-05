extends RayCast3D

@onready var ray = $"."
@onready var collide_label = $"../../../CanvasLayer/UI/InterLabel"
@onready var BG_label = $"../../../CanvasLayer/UI/InterLabel/BGlabel"

var current_collide = null


func _process(_delta: float) -> void:
	
	if ray.is_colliding():
		var collide = ray.get_collider()
		
		if collide.has_method("opening_door"):
			
			BG_label.visible = true
			collide_label.text = collide.name
			current_collide = collide
			
			if Input.is_action_just_pressed("Action_E") and current_collide:
				current_collide.opening_door()
			
		elif collide.has_method("interact_to_e"):
			
			BG_label.visible = true
			collide_label.text = collide.name
			current_collide = collide
			
			if collide.has_method("slide"):
				current_collide.slide()
			
			if Input.is_action_just_pressed("Action_E") and current_collide:
				current_collide.interact_to_e()
	else:
		BG_label.visible = false
		collide_label.text = ""
		current_collide = null
