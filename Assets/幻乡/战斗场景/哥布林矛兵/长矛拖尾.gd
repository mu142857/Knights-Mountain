extends Node2D

var scl: Vector2

func _ready() -> void:
	self.modulate = Color(1, 1, 1, 0.2)
	$Sprite2D.scale = scl

func _physics_process(delta: float) -> void:
	self.modulate.a -= 0.01
	if self.modulate.a <= 0:
		self.queue_free()
