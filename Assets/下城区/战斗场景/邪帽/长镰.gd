extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("wave")

func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()
