extends CharacterBody2D

func _process(delta: float) -> void:
	$"移动粒子".global_position.y = 900
	$"移动粒子".global_position.x = self.global_position.x + (self.scale.x * -180)
