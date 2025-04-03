extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("Ready")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Ready":
		$AnimatedSprite2D.play("Fire")
	if $AnimatedSprite2D.animation == "Fire":
		get_parent().queue_free()
