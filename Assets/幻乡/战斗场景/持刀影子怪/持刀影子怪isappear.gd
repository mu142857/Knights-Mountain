extends Basic_State

@onready var shadow: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	ani_sprite2d.play("Disappear")

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "Disappear":
		teleport()
		get_parent().change_state(1)
		

func teleport():
	shadow.hide()
	if is_instance_valid($"../../Rays/玩家检测射线右".get_collider()):
		var plrr = $"../../Rays/玩家检测射线右".get_collider()
		if plrr.is_in_group("player"):
			shadow.global_position.x = plrr.global_position.x + 100
			ani_sprite2d.scale.x = 1.52
			$"../../AttackChecks".scale.x = -1
			
	elif is_instance_valid($"../../Rays/玩家检测射线左".get_collider()):
		var plrl = $"../../Rays/玩家检测射线左".get_collider()
		if plrl.is_in_group("player"):
			shadow.global_position.x = plrl.global_position.x - 100
			ani_sprite2d.scale.x = -1.52
			$"../../AttackChecks".scale.x = 1
			
	else:
		shadow.global_position.x = randf_range(shadow.scene_startx, shadow.scene_endx)
