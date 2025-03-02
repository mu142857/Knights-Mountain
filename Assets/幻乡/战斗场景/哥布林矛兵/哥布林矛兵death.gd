extends Basic_State

func enter():
	$"../../AnimatedSprite2D".play("Death")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $"../../AnimatedSprite2D".animation == "Death":
		get_parent().get_parent().queue_free()
