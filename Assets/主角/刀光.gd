extends AnimatedSprite2D

var scl: Vector2

func _ready() -> void:
	self.modulate = Color(1, 1, 1, 0.8)
	self.scale = scl
	self.play("Default")

func _physics_process(delta: float) -> void:
	self.modulate.a -= 0.01

func _on_animation_finished() -> void:
	self.queue_free()
