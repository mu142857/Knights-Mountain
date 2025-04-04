extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("Fire")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Fire":
		self.queue_free()
