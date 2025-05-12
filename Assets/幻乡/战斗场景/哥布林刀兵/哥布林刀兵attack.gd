extends Basic_State

func enter():
	$"../../AnimationPlayer".play("Attack")

func process():
	if !$"../..".is_on_floor():
		$"../..".velocity.y += 15
		$"../..".move_and_slide()

func attack1_check():
	var arr = $"../../AttackChecks/Attack1".get_overlapping_bodies()
	attack_body(arr, 5)

func attack2_check():
	var arr = $"../../AttackChecks/Attack2".get_overlapping_bodies()
	attack_body(arr, 6)

func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)

func exit():
	$"../../AnimationPlayer".stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if $"../../AnimatedSprite2D".animation == "Attack":
		var prob: int = randf_range(0, 10)
		if prob % 2 == 0:
			get_parent().change_state(1)
		else:
			get_parent().change_state(0)
