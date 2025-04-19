extends Basic_State
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	$"../../AnimatedSprite2D".play("Death")
	Game.shake_camera(8)
	var expl = preload("res://Assets/下城区/战斗场景/残灯马/残灯马死亡粒子.tscn").instantiate()
	expl.position = $"../..".global_position + Vector2(0, -100)
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
	get_parent().get_parent().queue_free()
	
func process():
	if !$"../..".is_on_floor():
		$"../..".global_position.y = gravity
