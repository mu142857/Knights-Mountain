extends Node2D

var parent_array: Array
var player

func _ready() -> void:
	self.modulate = Color(1, 1, 1, 0)
	player = get_parent()
	parent_array = player.get_children()
	for i in parent_array:
		if i.is_in_group("player"):
			player = i


func _process(delta: float) -> void:

	if player.is_on_floor():
		if self.modulate.a <= 0.9:
			self.modulate.a += 0.05
		if self.scale.x < 1:
			self.scale.x = 1
			self.scale.y = 1
		self.global_position = player.global_position
	else:
		if self.modulate.a > 0.0:
			self.modulate.a -= 0.05
		if self.scale.x > 0:
			self.scale.x -= 0.1
			self.scale.y -= 0.1
