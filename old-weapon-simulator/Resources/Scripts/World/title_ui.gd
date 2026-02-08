extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Resources/Scenes/World/main_world.scn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
