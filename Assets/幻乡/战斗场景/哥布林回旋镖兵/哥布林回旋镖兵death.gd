extends Basic_State
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	$"../../AnimatedSprite2D".play("Death")
	
func process():
	if !$"../..".is_on_floor():
		$"../..".global_position.y = gravity
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if $"../../AnimatedSprite2D".animation == "Death":
		get_parent().get_parent().queue_free()
