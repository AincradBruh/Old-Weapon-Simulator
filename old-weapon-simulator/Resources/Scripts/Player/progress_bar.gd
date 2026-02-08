extends TextureProgressBar

@onready var timer = $"../../../InteractTimer"

#var max = self.max_value


func _process(_delta: float) -> void:
	self.value = timer.time_left * 10
