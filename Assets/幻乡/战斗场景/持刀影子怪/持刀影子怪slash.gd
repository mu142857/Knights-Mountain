extends Basic_State

func enter():
	if is_instance_valid($"../../Rays/玩家检测射线右".get_collider()):
		var plrr = $"../../Rays/玩家检测射线右".get_collider()
		if plrr.is_in_group("player"):
			$"../../AnimatedSprite2D".scale.x = -1.52
			$"../../AttackChecks".scale.x = 1
			
	if is_instance_valid($"../../Rays/玩家检测射线左".get_collider()):
		var plrl = $"../../Rays/玩家检测射线左".get_collider()
		if plrl.is_in_group("player"):
			$"../../AnimatedSprite2D".scale.x = 1.52
			$"../../AttackChecks".scale.x = -1
	$"../../AnimationPlayer".play("Attack")

func process():
	pass

func attack1_check():
	var arr = $"../../Attack Check/A1".get_overlapping_bodies()
	attack_body(arr, 5)

func attack2_check():
	var arr = $"../../Attack Check/A2l".get_overlapping_bodies()
	attack_body(arr, 4)
		
func attack3_check():
	var arr = $"../../Attack Check/A2r".get_overlapping_bodies()
	attack_body(arr, 3)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
			i.curse_of_shadow_debuff()

func _on_animated_sprite_2d_animation_finished() -> void:
	if $"../../AnimatedSprite2D".animation == "Attack":
		get_parent().change_state(0)
	
func exit():
	$"../../AnimationPlayer".stop()
