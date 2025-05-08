extends Basic_State

func enter():
	$"../..".queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
